import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../shared/i18n/app_translations.dart';
import '../../../../shared/widgets/text_custom.dart';
import '../../../../theme/theme.custom.app.dart';
import '../../domain/entities/project.entity.dart';

class ProjectCardMultilingual extends StatelessWidget {
  final ProjectEntity project;

  const ProjectCardMultilingual({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obter o idioma atual
    final String langCode = Localizations.localeOf(context).languageCode;

    // Obter os dados traduzidos para o idioma atual
    final name = project.getNameByLang(langCode);
    final description = project.getDescriptionByLang(langCode) ?? '';
    final client = project.getClientByLang(langCode) ?? '';

    return Card(
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CustomTheme.borderRadiusMedium),
      ),
      child: Container(
        width: 330,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do projeto
            if (project.image != null)
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(CustomTheme.borderRadiusSmall),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(CustomTheme.borderRadiusSmall),
                  child: Image.asset(
                    project.image!,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(CustomTheme.borderRadiusSmall),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: const Center(
                  child: Icon(
                    FontAwesomeIcons.code,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // Nome do projeto
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextCustom(
                    name,
                    fontSize: CustomTheme.fontSizeHeading6,
                    fontWeight: FontWeight.bold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (project.isHighlighted)
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
              ],
            ),

            const SizedBox(height: 8),

            // Tag indicando o tipo de projeto
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _getColorForProjectType(project.type).withOpacity(0.1),
                borderRadius: BorderRadius.circular(CustomTheme.borderRadiusSmall),
                border: Border.all(
                  color: _getColorForProjectType(project.type).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: TextCustom(
                _getProjectTypeText(project.type, langCode),
                fontSize: CustomTheme.fontSizeBodySmall - 1,
                color: _getColorForProjectType(project.type),
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            // Descrição do projeto
            Expanded(
              child: TextCustom(
                description,
                fontSize: CustomTheme.fontSizeBodySmall,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 16),

            // Tecnologias utilizadas
            if (project.technologies.isNotEmpty)
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: project.technologies.map((tech) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(CustomTheme.borderRadiusSmall),
                    ),
                    child: TextCustom(
                      tech,
                      fontSize: CustomTheme.fontSizeBodySmall - 2,
                      color: Colors.black87,
                    ),
                  );
                }).toList(),
              ),

            const SizedBox(height: 16),

            // Cliente e link para o projeto
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (client.isNotEmpty)
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.building,
                          size: 12,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: TextCustom(
                            client,
                            fontSize: 13,
                            color: Colors.grey.shade600,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (project.url != null)
                  IconButton(
                    onPressed: () async {
                      final url = Uri.parse(project.url!);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                    icon: Icon(
                      FontAwesomeIcons.externalLink,
                      size: 16,
                      color: CustomTheme.primaryColor,
                    ),
                    tooltip: Translate.text('openProject', context),
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(8),
                    splashRadius: 24,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForProjectType(ProjectType type) {
    switch (type) {
      case ProjectType.website:
        return CustomTheme.primaryColor;
      case ProjectType.app:
        return CustomTheme.secondaryColor;
      case ProjectType.websystem:
        return CustomTheme.accentColor;
      case ProjectType.software:
        return CustomTheme.errorColor;
      case ProjectType.apirest:
        return CustomTheme.warningColor;
      case ProjectType.other:
        return CustomTheme.infoColor;
    }
  }

  String _getProjectTypeText(ProjectType type, String langCode) {
    switch (type) {
      case ProjectType.website:
        return langCode == 'pt' ? 'Website' : 'Website';
      case ProjectType.app:
        return langCode == 'pt' ? 'Aplicativo' : 'App';
      case ProjectType.websystem:
        return langCode == 'pt' ? 'Sistema Web' : 'Web System';
      case ProjectType.software:
        return langCode == 'pt' ? 'Software' : 'Software';
      case ProjectType.apirest:
        return langCode == 'pt' ? 'API REST' : 'REST API';
      case ProjectType.other:
        return langCode == 'pt' ? 'Outro' : 'Other';
    }
  }
}
