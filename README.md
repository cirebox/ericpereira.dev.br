# ericpereira.dev.br

![Flutter](https://img.shields.io/badge/Flutter-3.1.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.1.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Web](https://img.shields.io/badge/Web-Responsive-4285F4?style=for-the-badge&logo=google-chrome&logoColor=white)
![Multilanguage](https://img.shields.io/badge/i18n-PT/EN/ES-FF6F00?style=for-the-badge&logo=translation&logoColor=white)

Site pessoal de portfólio desenvolvido com Flutter Web, com suporte a múltiplos idiomas e página inicial no formato landing page.

## 📋 Sobre o Projeto

Este projeto é meu site pessoal que apresenta informações sobre mim, meu portfólio de projetos e demais informações profissionais. O site foi desenvolvido com foco em responsividade, utilizando as melhores práticas de desenvolvimento Flutter para a web.

## 🏗️ Arquitetura

O projeto utiliza a arquitetura de módulos com Flutter Modular e segue os princípios de Clean Architecture:

- **Módulos**: Cada seção do site é um módulo independente (Home, Sobre, Portfólio)
- **Clean Architecture**: Separação em camadas (data, domain, presenter)
- **Gerenciamento de Estado**: 
  - Flutter Triple: Implementação do padrão Store/Triple para gerenciamento de estados reativos
  - Provider: Gerenciamento de estado complementar (usado para o tema e internacionalização)
- **Injeção de Dependências**: Flutter Modular para injeção e controle de ciclo de vida
- **Internacionalização**: Suporte a múltiplos idiomas (Português, Inglês e Espanhol)
- **Either Pattern**: Uso do pacote Dartz para tratamento funcional de erros/sucesso

## 📁 Estrutura de Pastas

```
lib/
├── main.dart                          # Ponto de entrada da aplicação
├── app/                               # Diretório principal da aplicação
│   ├── app_module.dart                # Módulo principal da aplicação
│   ├── app_widget.dart                # Widget principal da aplicação
│   ├── core/                          # Classes e serviços fundamentais
│   │   ├── domain/                    # Exceções e interfaces centrais
│   │   └── either_adapter/            # Adaptador para o padrão Either (dartz)
│   ├── modules/                       # Módulos da aplicação
│   │   ├── home/                      # Módulo de página inicial (landing page)
│   │   │   ├── home_module.dart       # Configuração do módulo Home
│   │   │   ├── home_page.dart         # Página principal (landing page)
│   │   │   ├── sections/              # Seções da landing page
│   │   │   ├── store/                 # Gerenciadores de estado
│   │   │   └── widgets/               # Componentes específicos da home
│   │   ├── about/                     # Módulo de página completa sobre
│   │   └── portfolio/                 # Módulo de portfólio
│   ├── shared/                        # Componentes e serviços compartilhados
│   │   ├── i18n/                      # Internacionalização
│   │   ├── models/                    # Modelos compartilhados
│   │   ├── services/                  # Serviços compartilhados
│   │   └── widgets/                   # Widgets reutilizáveis
│   └── theme/                         # Configuração de temas
├── assets/                            # Recursos estáticos
│   ├── data/                          # Arquivos de dados
│   └── images/                        # Imagens do projeto
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
| HTTP | 1.1.0 | Requisições HTTP para o serviço de e-mail |
| Shared Preferences | 2.2.2 | Armazenamento local para preferências do usuário |

## 🌐 Idiomas Suportados

O site suporta os seguintes idiomas:

- 🇧🇷 Português (Brasil) - Idioma padrão
- 🇺🇸 Inglês (Estados Unidos)
- 🇪🇸 Espanhol (Espanha)

## 💻 Navegadores Suportados

O site foi otimizado para funcionar nos seguintes navegadores:

- Google Chrome
- Firefox
- Microsoft Edge
- Safari

## 📱 Versão para Produção

Para gerar uma versão otimizada para produção:

```bash
# Build com CanvasKit (recomendado para melhor qualidade visual)
flutter build web --release --web-renderer canvaskit

# OU Build com HTML (menor tamanho e melhor compatibilidade)
flutter build web --release --web-renderer html
```

## 📱 Recursos e Funcionalidades

O site conta com as seguintes áreas:

### 🏠 Página Inicial (Landing Page)
- Seção Sobre: Apresentação visual e profissional
- Seção Novidades: Últimas atualizações e notícias
- Seção Contato: Formulário para envio de mensagens

### 👨‍💻 Sobre
- Informações pessoais e profissionais
- Histórico profissional e formação
- Habilidades e competências

### 💼 Portfólio
- Showcase de projetos desenvolvidos
- Detalhes técnicos e descrições
- Imagens e links para os projetos

## 🧩 Recursos Técnicos

- **Tema Claro/Escuro**: Sistema de alternância de temas
- **Multi-idioma**: Suporte a Português, Inglês e Espanhol
- **Design Responsivo**: Adaptável a diferentes tamanhos de tela
- **PWA**: Possibilidade de instalação como aplicativo
- **Navegação Modular**: Rotas organizadas e eficientes
- **Integração WhatsApp**: Contato direto via WhatsApp
- **Formulário de Contato**: Envio de mensagens por e-mail

---
Desenvolvido por Eric Pereira