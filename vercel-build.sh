#!/bin/bash

# Baixar o Flutter
if [ -d "flutter" ]; then
  echo "Atualizando o Flutter..."
  cd flutter
  git pull
  cd ..
else
  echo "Clonando o Flutter..."
  git clone https://github.com/flutter/flutter.git
fi

# Adicionar Flutter ao PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Verificar instalação do Flutter sem executar como root
flutter doctor

# Limpar qualquer build anterior
flutter clean

# Habilitar suporte para web
flutter config --enable-web

# Fazer o build do projeto para web com otimização
# Removendo o parâmetro --web-renderer que não está disponível nesta versão
flutter build web --release

# Verificar se o diretório build/web foi criado com sucesso
if [ -d "build/web" ]; then
  echo "Diretório build/web criado com sucesso!"
  
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
  
  echo "Build concluído com sucesso!"
else
  echo "ERRO: O diretório build/web não foi criado!"
  ls -la build/ || echo "Diretório 'build' não existe!"
  exit 1
fi
