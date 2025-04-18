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

# Fazer o build do projeto para web
flutter build web

echo "Build concluído com sucesso!"
