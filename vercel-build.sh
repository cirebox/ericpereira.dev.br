#!/bin/bash

# Definir versão do Flutter
FLUTTER_VERSION="3.19.3"

# Baixar o Flutter usando URL direta em vez de git clone
if [ -d "flutter" ]; then
  echo "Flutter já existe, usando a versão existente..."
else
  echo "Baixando Flutter $FLUTTER_VERSION..."
  mkdir -p flutter
  curl -L "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" -o flutter.tar.xz
  tar xf flutter.tar.xz -C .
  rm flutter.tar.xz
fi

# Adicionar Flutter ao PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Verificar instalação do Flutter
flutter --version
flutter doctor

# Limpar qualquer build anterior
flutter clean

# Habilitar suporte para web
flutter config --enable-web

# Fazer o build do projeto para web com otimização
# Removendo o parâmetro --web-renderer que não está disponível nesta versão
flutter build web --release
flutter build web --release

# Verificar se o diretório build/web foi criado com sucesso
if [ -d "build/web" ]; then
  echo "Diretório build/web criado com sucesso!"
  
  # Garantir que os diretórios de ícones e imagens existam
  mkdir -p build/web/icons
  
  # Copiar ícones da pasta web para build/web se existirem
  if [ -d "web/icons" ]; then
    echo "Copiando ícones para build/web/icons..."
    cp -r web/icons/* build/web/icons/
  fi
  
  # Copiar favicon se existir
  if [ -f "web/favicon.png" ]; then
    echo "Copiando favicon.png para build/web..."
    cp web/favicon.png build/web/
  fi
  
  # Garantir que os tipos MIME estejam configurados corretamente
  echo "Ajustando arquivos para o deploy na Vercel..."
  
  # Criar arquivo _headers para definir tipos MIME
  cat > build/web/_headers << EOL
/*
  Content-Type: text/html; charset=utf-8

/main.dart.js
  Content-Type: application/javascript

/flutter_service_worker.js
  Content-Type: application/javascript

/flutter.js
  Content-Type: application/javascript

/*.js
  Content-Type: application/javascript

/*.json
  Content-Type: application/json
EOL
  
  # Criar ou atualizar o arquivo web.config para IIS
  cat > build/web/web.config << EOL
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <system.webServer>
    <staticContent>
      <mimeMap fileExtension=".json" mimeType="application/json" />
      <mimeMap fileExtension=".js" mimeType="application/javascript" />
    </staticContent>
    <rewrite>
      <rules>
        <rule name="Flutter Routes" stopProcessing="true">
          <match url=".*" />
          <conditions logicalGrouping="MatchAll">
            <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
            <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
          </conditions>
          <action type="Rewrite" url="/" />
        </rule>
      </rules>
    </rewrite>
  </system.webServer>
</configuration>
EOL

  # Criar arquivo manifest.json caso não exista
  if [ ! -f "build/web/manifest.json" ]; then
    echo "Criando manifest.json básico..."
    cat > build/web/manifest.json << EOL
{
  "name": "Eric Pereira - Portfolio",
  "short_name": "Eric Pereira",
  "start_url": ".",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#0175C2",
  "description": "Portfolio profissional de Eric Pereira",
  "orientation": "portrait-primary",
  "prefer_related_applications": false,
  "icons": [
    {
      "src": "icons/Icon-192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "icons/Icon-512.png",
      "sizes": "512x512",
      "type": "image/png"
    },
    {
      "src": "icons/Icon-maskable-192.png",
      "sizes": "192x192",
      "type": "image/png",
      "purpose": "maskable"
    },
    {
      "src": "icons/Icon-maskable-512.png",
      "sizes": "512x512",
      "type": "image/png",
      "purpose": "maskable"
    }
  ]
}
EOL
  fi
  
  # Verificar e atualizar o index.html para corrigir meta tags
  if [ -f "build/web/index.html" ]; then
    echo "Atualizando meta tags no index.html..."
    # Adiciona a meta tag mobile-web-app-capable se não existir
    grep -q 'mobile-web-app-capable' build/web/index.html || sed -i '/<meta name="apple-mobile-web-app-capable" content="yes">/a \  <meta name="mobile-web-app-capable" content="yes">' build/web/index.html
  fi
  
  echo "Build concluído com sucesso!"
else
  echo "ERRO: O diretório build/web não foi criado!"
  ls -la build/ || echo "Diretório 'build' não existe!"
  exit 1
fi
