import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/domain/exceptions/exceptions.dart';
import '../../../shared/i18n/app_translations.dart';
import '../../../shared/services/openwhatsapp.service.dart';
import '../../../shared/widgets/layout_page.dart';
import '../../../shared/widgets/text_custom.dart';
import '../../../theme/theme.custom.app.dart';
import '../domain/entities/project.entity.dart';
import 'portfolio_store.dart';

class PortfolioPage extends StatefulWidget {
  final String title;
  const PortfolioPage({Key? key, this.title = 'Portfolio'}) : super(key: key);

  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  var store = Modular.get<PortfolioStore>();
  ProjectType? _selectedFilter;
  String? _searchTerm;
  final TextEditingController _searchController = TextEditingController();

  // Método auxiliar para criar o cartão de projeto
  Widget _buildProjectCard(ProjectEntity project) {
    return _ProjectCard(
      project: project,
      key: Key('project-card-${project.id}'),
    );
  }

  // Widget local para exibir o cartão de projeto
  // Esta é uma implementação temporária para contornar o problema de importação
  Widget _ProjectCard({required ProjectEntity project, Key? key}) {
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
                  borderRadius:
                      BorderRadius.circular(CustomTheme.borderRadiusSmall),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(CustomTheme.borderRadiusSmall),
                  child: Image.asset(
                    project.image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // Nome do projeto
            TextCustom(
              name,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(height: 8),

            // Cliente
            if (client.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.business,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextCustom(
                        client,
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),

            // Descrição
            TextCustom(
              description,
              fontSize: 14,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            // Tecnologias
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: project.technologies.map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: CustomTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: CustomTheme.primaryColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: TextCustom(
                    tech,
                    fontSize: 12,
                    color: CustomTheme.primaryColor,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Ano e Tipo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    TextCustom(
                      '${project.year}',
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getColorByType(project.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextCustom(
                    _getTypeLabel(project.type, langCode),
                    fontSize: 12,
                    color: _getColorByType(project.type),
                  ),
                ),
              ],
            ),

            // Link para o projeto
            if (project.url != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: InkWell(
                  onTap: () => _launchURL(project.url!),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.link,
                        size: 16,
                        color: CustomTheme.primaryColor,
                      ),
                      const SizedBox(width: 4),
                      TextCustom(
                        Translate.text('visitProject', context),
                        fontSize: 14,
                        color: CustomTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Função auxiliar para lançar URL
  void _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(Translate.text('errorOpeningUrl', context)),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Translate.text('errorOpeningUrl', context) + ': ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Função auxiliar para obter a cor com base no tipo
  Color _getColorByType(ProjectType type) {
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
      default:
        return CustomTheme.infoColor;
    }
  }

  // Função auxiliar para obter o rótulo do tipo com base no idioma
  String _getTypeLabel(ProjectType type, String langCode) {
    switch (type) {
      case ProjectType.website:
        return Translate.text('projectTypeWebsite', context);
      case ProjectType.app:
        return Translate.text('projectTypeApp', context);
      case ProjectType.websystem:
        return Translate.text('projectTypeWebSystem', context);
      case ProjectType.software:
        return Translate.text('projectTypeSoftware', context);
      case ProjectType.apirest:
        return Translate.text('projectTypeAPI', context);
      default:
        return Translate.text('projectTypeOther', context);
    }
  }

  @override
  void initState() {
    store.getProjects();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ProjectEntity> _filterProjects(List<ProjectEntity> projects) {
    var filteredProjects = projects;

    // Obter o idioma atual
    final String langCode = Localizations.localeOf(context).languageCode;

    // Aplicar filtro por tipo
    if (_selectedFilter != null) {
      filteredProjects = filteredProjects
          .where((project) => project.type == _selectedFilter)
          .toList();
    }

    // Aplicar filtro por termo de busca
    if (_searchTerm != null && _searchTerm!.isNotEmpty) {
      filteredProjects = filteredProjects
          .where((project) =>
              project
                  .getNameByLang(langCode)
                  .toLowerCase()
                  .contains(_searchTerm!.toLowerCase()) ||
              (project
                      .getDescriptionByLang(langCode)
                      ?.toLowerCase()
                      .contains(_searchTerm!.toLowerCase()) ??
                  false) ||
              (project
                      .getClientByLang(langCode)
                      ?.toLowerCase()
                      .contains(_searchTerm!.toLowerCase()) ??
                  false))
          .toList();
    }

    return filteredProjects;
  }

  Widget _buildFilterChip(ProjectType type, String label, Color color) {
    final isSelected = _selectedFilter == type;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: FilterChip(
        label: TextCustom(
          label,
          fontSize: CustomTheme.fontSizeBodySmall,
          color: isSelected ? Colors.white : color,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
        selected: isSelected,
        selectedColor: color,
        checkmarkColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: isSelected ? 2 : 0,
        pressElevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CustomTheme.borderRadiusMedium),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: CustomTheme.spacingSmall,
          vertical: CustomTheme.spacingXSmall,
        ),
        side: BorderSide(
          color: isSelected ? color : color.withOpacity(0.3),
          width: isSelected ? 1.5 : 1,
        ),
        shadowColor: color.withOpacity(0.3),
        onSelected: (selected) {
          setState(() {
            _selectedFilter = selected ? type : null;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutPage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 40), // Título e Descrição
          Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: TextCustom(
                    Translate.text('portfolio', context),
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        CustomTheme.primaryColor.withOpacity(0.7),
                        CustomTheme.secondaryColor.withOpacity(0.7),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius:
                        BorderRadius.circular(CustomTheme.borderRadiusMedium),
                  ),
                  height: 4,
                  width: 80,
                  margin: const EdgeInsets.only(bottom: 24),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextCustom(
                    Translate.text('portfolioIntro', context),
                    fontSize: 17,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Barra de pesquisa e filtros
          Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: Translate.text('searchProjects', context),
                      hintStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: CustomTheme.fontSizeBodySmall,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: CustomTheme.primaryColor,
                        size: 22,
                      ),
                      suffixIcon: _searchTerm != null && _searchTerm!.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: CustomTheme.primaryColor,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchTerm = null;
                                });
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            CustomTheme.borderRadiusMedium),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            CustomTheme.borderRadiusMedium),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            CustomTheme.borderRadiusMedium),
                        borderSide: BorderSide(
                          color: CustomTheme.primaryColor,
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: CustomTheme.spacingMedium,
                        vertical: CustomTheme.spacingSmall,
                      ),
                      isDense: true,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchTerm = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Chips de filtro
          Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildFilterChip(
                    ProjectType.website,
                    Translate.text('websites', context),
                    CustomTheme.primaryColor),
                _buildFilterChip(
                    ProjectType.app,
                    Translate.text('apps', context),
                    CustomTheme.secondaryColor),
                _buildFilterChip(
                    ProjectType.websystem,
                    Translate.text('webSystems', context),
                    CustomTheme.accentColor),
                _buildFilterChip(
                    ProjectType.software,
                    Translate.text('softwares', context),
                    CustomTheme.errorColor),
                _buildFilterChip(ProjectType.apirest,
                    Translate.text('apis', context), CustomTheme.warningColor),
                _buildFilterChip(ProjectType.other,
                    Translate.text('others', context), CustomTheme.infoColor),
                if (_selectedFilter != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ActionChip(
                      label: TextCustom(Translate.text('clearFilters', context),
                          fontSize: 14),
                      avatar: const Icon(Icons.clear, size: 18),
                      onPressed: () {
                        setState(() {
                          _selectedFilter = null;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Lista de projetos
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ScopedBuilder<PortfolioStore, Failure, List<ProjectEntity>>(
              store: store,
              onLoading: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
              onError: (context, error) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    TextCustom(
                      Translate.text('errorLoadingProjects', context) +
                          ': ${error.toString()}',
                      fontSize: 16,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => store.getProjects(),
                      child: TextCustom(Translate.text('tryAgain', context)),
                    ),
                  ],
                ),
              ),
              onState: (context, projectsList) {
                final filteredProjects = _filterProjects(projectsList);

                if (filteredProjects.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        const Icon(
                          FontAwesomeIcons.folderOpen,
                          size: 48,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        TextCustom(
                          _searchTerm != null && _searchTerm!.isNotEmpty
                              ? Translate.text('noProjectsFound', context) +
                                  ' "$_searchTerm"'
                              : Translate.text('noProjectsForFilter', context),
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  );
                }

                return Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Cálculo para determinar quantos cards por linha baseado na largura disponível
                      final cardWidth = 330.0;
                      final cardSpacing =
                          32.0; // Aumentando o espaçamento entre os cards
                      final availableWidth = constraints.maxWidth;
                      int cardsPerRow =
                          (availableWidth / (cardWidth + cardSpacing)).floor();
                      cardsPerRow = cardsPerRow < 1 ? 1 : cardsPerRow;

                      // Centralizando os cards e distribuindo o espaço de forma mais equilibrada

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: cardsPerRow,
                            childAspectRatio:
                                330 / 300, // Ajustando para a nova altura
                            crossAxisSpacing: 2,
                            mainAxisSpacing:
                                2, // Aumentando o espaçamento vertical
                          ),
                          itemCount: filteredProjects.length,
                          itemBuilder: (context, index) {
                            final project = filteredProjects[index];
                            return Center(
                              child: _buildProjectCard(project),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 40),

          // Footer específico do portfólio
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            color: Colors.black.withOpacity(0.05),
            child: Center(
              child: Column(
                children: [
                  TextCustom(
                    Translate.text('interestedInWorking', context),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => whatsAppOpen(context),
                    icon: const FaIcon(FontAwesomeIcons.whatsapp),
                    label: TextCustom(
                      Translate.text('contactMe', context),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
