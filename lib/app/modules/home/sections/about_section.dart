import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../shared/i18n/app_translations.dart';
import '../../../shared/widgets/social_buttons.dart';
import '../../../shared/widgets/text_custom.dart';
import 'news_section.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      final isDesktop =
          sizingInformation.deviceScreenType == DeviceScreenType.desktop;

      if (isDesktop) {
        // Layout para desktop com duas seções separadas
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Conteúdo principal centralizado (lado esquerdo)
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    margin:
                        const EdgeInsets.only(top: 40, bottom: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black12
                          : Colors.grey[50],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildDesktopMainContent(context),
                      ],
                    ),
                  ),
                  // Divisor
                  _buildDivider(),

                  // Seção de novidades incluída abaixo da biografia
                  const NewsSection(),
                ],
              ),
            ),

            // Painel lateral direito como seção independente
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(top: 40, bottom: 40),
                child: _buildSidePanel(context),
              ),
            ),
          ],
        );
      } else {
        // Layout para mobile permanece com uma coluna
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          margin: const EdgeInsets.only(top: 40, bottom: 40),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black12
                : Colors.grey[50],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              _buildMobileLayout(context),

              const SizedBox(height: 40),

              // Seção de novidades incluída abaixo da biografia
              const NewsSection(),
            ],
          ),
        );
      }
    });
  }

  Widget _buildDesktopMainContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Coluna esquerda: Foto de perfil + botões sociais
        Expanded(
          flex: 2,
          child: Column(
            children: [
              // Foto de perfil
              _buildProfileImage(),

              // Espaçamento
              const SizedBox(height: 30),

              // Botões sociais
              const SocialButtons(),
            ],
          ),
        ),

        const SizedBox(width: 60),

        // Apenas biografia
        Expanded(
          flex: 3,
          child: _buildBiographyContent(context),
        ),
      ],
    );
  }

  Widget _buildBiographyContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Biografia
        TextCustom(
          Translate.text('aboutDescription', context),
          fontSize: 16,
          fontWeight: FontWeight.w400,
          textHeight: 1.6,
          color:
              Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        // Foto de perfil
        _buildProfileImage(),

        // Espaçamento
        const SizedBox(height: 30),

        // Botões sociais
        const SocialButtons(),

        const SizedBox(height: 30),

        // Biografia
        _buildBiographyContent(context),

        const SizedBox(height: 30),

        // Conteúdo que estaria no painel lateral (em mobile fica abaixo)
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black12
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Experiência, Formação e Habilidades vêm aqui
              // Reutilizamos o mesmo conteúdo do painel lateral
              ..._buildSidePanelContent(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/images/profile.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSidePanel(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black12
            : Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildSidePanelContent(context),
      ),
    );
  }

  List<Widget> _buildSidePanelContent(BuildContext context) {
    return [
      // Experiência
      TextCustom(
        Translate.text('experience', context),
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.titleLarge?.color,
      ),
      const SizedBox(height: 10),
      _buildExperienceItem(
        context,
        company: Translate.text('companyCircebox', context),
        position: Translate.text('positionCEO', context),
        period: Translate.text('periodSince2019', context),
      ),

      const SizedBox(height: 20),

      // Formação
      TextCustom(
        Translate.text('education', context),
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.titleLarge?.color,
      ),
      const SizedBox(height: 10),
      _buildEducationItem(
        context,
        institution: Translate.text('institutionEstacio', context),
        degree: Translate.text('degreeAnalysis', context),
        year: Translate.text('period20212024', context),
      ),

      const SizedBox(height: 20),

      // Habilidades
      TextCustom(
        Translate.text('skills', context),
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.titleLarge?.color,
      ),
      const SizedBox(height: 15),

      // Front-end
      _buildSkillCategory(context, 'frontend', [
        'react',
        'nextjs',
        'javascript',
        'typescript',
        'html',
        'css',
        'tailwind',
      ]),

      const SizedBox(height: 15),

      // Back-end
      _buildSkillCategory(context, 'backend', [
        'nodejs',
        'express',
        'nestjs',
      ]),

      const SizedBox(height: 15),

      // Mobile
      _buildSkillCategory(context, 'mobile', [
        'flutter',
        'dart',
      ]),

      const SizedBox(height: 15),

      // Banco de Dados
      _buildSkillCategory(context, 'database', [
        'postgresql',
        'mongodb',
        'firebase',
      ]),

      const SizedBox(height: 15),

      // Ferramentas
      _buildSkillCategory(context, 'tools', [
        'git',
        'docker',
        'kubernetes',
        'aws',
        'figma',
      ]),
    ];
  }

  Widget _buildSkillCategory(
      BuildContext context, String categoryKey, List<String> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título da categoria
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: TextCustom(
            Translate.text(categoryKey, context),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),

        // Lista de habilidades
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) => _buildSkillChip(skill)).toList(),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String skillKey) {
    return Builder(
      builder: (context) => Chip(
        label: Text(
          Translate.text(skillKey, context),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.blue.withOpacity(0.1),
        side: BorderSide(color: Colors.blue.withOpacity(0.3)),
      ),
    );
  }

  Widget _buildExperienceItem(
    BuildContext context, {
    required String company,
    required String position,
    required String period,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextCustom(
            company,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.titleMedium?.color,
          ),
          const SizedBox(height: 2),
          TextCustom(
            position,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          const SizedBox(height: 2),
          TextCustom(
            period,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color:
                Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationItem(
    BuildContext context, {
    required String institution,
    required String degree,
    required String year,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextCustom(
            institution,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.titleMedium?.color,
          ),
          const SizedBox(height: 2),
          TextCustom(
            degree,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          const SizedBox(height: 2),
          TextCustom(
            year,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color:
                Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}

Widget _buildDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
    child: Container(
      height: 0.5,
      color: Colors.grey.withOpacity(0.5),
    ),
  );
}
