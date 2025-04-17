# ericpereira.dev.br

![Flutter](https://img.shields.io/badge/Flutter-3.1.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.1.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Web](https://img.shields.io/badge/Web-Responsive-4285F4?style=for-the-badge&logo=google-chrome&logoColor=white)

Site pessoal de portfólio desenvolvido com Flutter Web.

## 📋 Sobre o Projeto

Este projeto é meu site pessoal que apresenta informações sobre mim, meu portfólio de projetos e demais informações profissionais. O site foi desenvolvido com foco em responsividade, utilizando as melhores práticas de desenvolvimento Flutter para a web.

## 🏗️ Arquitetura

O projeto utiliza a arquitetura de módulos com Flutter Modular e segue os princípios de Clean Architecture:

- **Módulos**: Cada seção do site é um módulo independente (Home, Sobre, Portfólio)
- **Clean Architecture**: Separação em camadas (data, domain, presenter)
- **Gerenciamento de Estado**: 
  - Flutter Triple: Implementação do padrão Store/Triple para gerenciamento de estados reativos
  - Provider: Gerenciamento de estado complementar (usado para o tema)
- **Injeção de Dependências**: Flutter Modular para injeção e controle de ciclo de vida
- **Either Pattern**: Uso do pacote Dartz para tratamento funcional de erros/sucesso

## 📁 Estrutura de Pastas

```
lib/
├── main.dart                  # Ponto de entrada da aplicação
├── app/
│   ├── app_module.dart        # Módulo principal da aplicação
│   ├── app_widget.dart        # Widget principal da aplicação
│   ├── core/                  # Classes fundamentais 
│   │   ├── domain/            # Exceções e interfaces centrais
│   │   └── either_adapter/    # Adaptador para o padrão Either (dartz)
│   ├── modules/               # Módulos da aplicação
│   │   ├── home/              # Módulo de página inicial
│   │   │   ├── home_module.dart      # Configuração do módulo Home
│   │   │   └── home_page.dart        # Implementação da página inicial
│   │   ├── portfolio/         # Módulo de portfólio (Clean Architecture)
│   │   │   ├── portfolio_module.dart # Configuração do módulo Portfolio
│   │   │   ├── data/                 # Camada de dados
│   │   │   │   ├── models/           # Modelos/DTOs
│   │   │   │   └── repositories/     # Implementação dos repositórios
│   │   │   ├── domain/               # Regras de negócio
│   │   │   │   ├── entities/         # Entidades de domínio
│   │   │   │   ├── repositories/     # Interfaces dos repositórios
│   │   │   │   └── usecases/         # Casos de uso
│   │   │   └── presenter/            # Camada de apresentação
│   │   │       ├── portfolio_page.dart  # Página principal de portfólio
│   │   │       ├── portfolio_store.dart # Gerenciamento de estado (Triple)
│   │   │       └── widgets/          # Componentes da UI
│   │   └── sobre/             # Módulo de informações pessoais
│   │       ├── about_module.dart     # Configuração do módulo Sobre
│   │       ├── about_page.dart       # Página principal Sobre
│   │       └── widgets/              # Componentes específicos (perfil, descrição)
│   ├── shared/                # Componentes compartilhados
│   │   ├── services/          # Serviços (navegação, integração)
│   │   │   ├── navigation.service.dart   # Serviço de navegação
│   │   │   └── openwhatsapp.service.dart # Serviço para abrir WhatsApp
│   │   └── widgets/           # Widgets reutilizáveis
│   │       ├── header.dart          # Cabeçalho do site
│   │       ├── footer.dart          # Rodapé do site
│   │       ├── layout_page.dart     # Template para layout padrão
│   │       ├── menu.dart            # Menu de navegação
│   │       ├── button_theme.dart    # Botão de troca de tema
│   │       └── snackbar/            # Notificações
│   └── theme/                 # Configuração de temas
│       ├── theme.config.dart        # Configurações de tema (cores, tipografia)
│       └── theme.custom.app.dart    # Implementação do tema customizado
├── assets/                    # Recursos estáticos
│   └── images/                # Imagens do projeto (portfólio, logos)
```

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Versão | Finalidade |
|------------|--------|------------|
| Flutter | 3.1.0+ | SDK para desenvolvimento multiplataforma |
| Dart | 3.1.0+ | Linguagem de programação |
| Flutter Modular | 5.0.3 | Estruturação modular e injeção de dependências |
| Flutter Triple | 1.2.7+4 | Gerenciamento de estado reativo |
| Provider | 6.1.2 | Gerenciamento de estado complementar |
| Dartz | 0.10.1 | Programação funcional (Either para tratamento de erros) |
| Responsive Builder | 0.7.1 | Suporte para design responsivo |
| URL Launcher | 6.1.10 | Interação com URLs externas e redes sociais |
| Font Awesome Flutter | 10.7.0 | Ícones e fontes de ícones |
| Google Fonts | 5.1.0 | Tipografia personalizada |
| Flutter Localization | - | Internacionalização |

## 💻 Navegadores Suportados

O site foi otimizado para funcionar nos seguintes navegadores:

- Google Chrome
- Firefox
- Microsoft Edge
- Safari

## 📌 Requisitos

- Flutter: 3.1.0 ou superior
- Dart SDK: 3.1.0 ou superior
- Git: Para clone do repositório
- Navegador web atualizado

## 🚀 Como Executar

### Configuração do Ambiente

1. Instale o Flutter SDK (versão 3.1.0 ou superior):
   ```bash
   # Você pode baixar do site oficial e adicionar ao PATH ou usar um gerenciador como FVM
   # Com FVM:
   dart pub global activate fvm
   fvm install 3.1.0
   fvm use 3.1.0
   ```

2. Verifique a instalação:
   ```bash
   flutter doctor
   ```

### Executando o Projeto

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/ericpereira.dev.br.git
   cd ericpereira.dev.br
   ```

2. Instale as dependências:
   ```bash
   flutter pub get
   ```

3. Execute o projeto em modo de desenvolvimento:
   ```bash
   # Com renderizador CanvasKit (melhor qualidade, maior tamanho)
   flutter run -d chrome --web-renderer canvaskit
   
   # OU com renderizador HTML (menor tamanho, compatibilidade)
   flutter run -d chrome --web-renderer html
   ```

4. Rotas disponíveis durante o desenvolvimento:
   - http://localhost:PORT/ - Página inicial
   - http://localhost:PORT/sobre - Página Sobre
   - http://localhost:PORT/portfolio - Página de Portfólio
   - http://localhost:PORT/blog - Blog (em desenvolvimento)

### Ambiente de Desenvolvimento

- **VS Code**: Recomendado com extensões Flutter e Dart
- **Android Studio/IntelliJ**: Alternativa com plugins Flutter e Dart
- **DevTools**: Execute `flutter pub global activate devtools` para ferramentas de depuração

## 📱 Versão para Produção

Para gerar uma versão otimizada para produção:

```bash
# Build com CanvasKit (recomendado para melhor qualidade visual)
flutter build web --release --web-renderer canvaskit

# OU Build com HTML (menor tamanho e melhor compatibilidade)
flutter build web --release --web-renderer html
```

### Otimizações para produção
- Os arquivos de produção serão gerados na pasta `build/web/`
- Você pode servir esses arquivos em qualquer servidor web estático
- Recomendações para hospedagem: GitHub Pages, Netlify, Vercel, Firebase Hosting

### PWA (Progressive Web App)
O projeto está configurado para funcionar como PWA, permitindo instalação nos dispositivos dos usuários. Para testar a funcionalidade PWA:

```bash
flutter build web --release --web-renderer canvaskit --pwa-strategy offline-first
```

## 📱 Recursos e Funcionalidades

O site conta com as seguintes áreas:

### 🏠 Página Inicial
- Apresentação visual e profissional
- Seção de destaque com CTA (Call to Action)
- Links para redes sociais e contato direto

### 👨‍💻 Sobre
- Informações pessoais e profissionais
- Histórico profissional e formação
- Habilidades e competências

### 💼 Portfólio
- Showcase de projetos desenvolvidos
- Detalhes técnicos e descrições
- Imagens e links para os projetos

### 📝 Blog (em desenvolvimento)
- Artigos e publicações técnicas (em implementação)

## 🧩 Recursos Técnicos

- **Tema Claro/Escuro**: Sistema de alternância de temas
- **Design Responsivo**: Adaptável a diferentes tamanhos de tela
- **PWA**: Possibilidade de instalação como aplicativo
- **Navegação Modular**: Rotas organizadas e eficientes
- **Integração WhatsApp**: Contato direto via WhatsApp

## 🧪 Testes

O projeto utiliza testes para garantir a qualidade do código:

```bash
# Executar todos os testes
flutter test

# Executar um teste específico
flutter test test/path/to/test.dart

# Executar testes com cobertura
flutter test --coverage
```

## 📊 Análise de Código

Para manter a qualidade do código:

```bash
# Verificar problemas de formatação e regras de lint
flutter analyze
```

## 🤝 Contribuindo

Este é um projeto pessoal, mas sugestões são bem-vindas. Se você encontrar algum problema ou tiver uma sugestão, sinta-se à vontade para abrir uma issue.

## 📜 Licença

Este projeto é de uso pessoal.

---
Desenvolvido por Eric Pereira