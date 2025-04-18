import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/domain/exceptions/exceptions.dart';
import '../../../shared/services/openwhatsapp.service.dart';
import '../../../shared/widgets/layout_page.dart';
import '../../../shared/widgets/text_custom.dart';
import '../../../theme/theme.custom.app.dart';
import '../domain/entities/project.entity.dart';
import 'portfolio_store.dart';
import 'widgets/project_card_enhanced.dart';

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
              project.name.toLowerCase().contains(_searchTerm!.toLowerCase()) ||
              (project.description
                      ?.toLowerCase()
                      .contains(_searchTerm!.toLowerCase()) ??
                  false) ||
              (project.client
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
          const SizedBox(height: 40),
          // Título e Descrição
          Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const TextCustom(
                    'Meu Portfólio',
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
                  child: const TextCustom(
                    'Projetos desenvolvidos ao longo da minha carreira como desenvolvedor. Cada projeto representa uma jornada única de aprendizado e crescimento profissional.',
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
                      hintText: 'Pesquisar projetos...',
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
                    ProjectType.website, 'Websites', CustomTheme.primaryColor),
                _buildFilterChip(
                    ProjectType.app, 'Aplicativos', CustomTheme.secondaryColor),
                _buildFilterChip(ProjectType.websystem, 'Sistemas Web',
                    CustomTheme.accentColor),
                _buildFilterChip(
                    ProjectType.software, 'Softwares', CustomTheme.errorColor),
                _buildFilterChip(
                    ProjectType.apirest, 'APIs', CustomTheme.warningColor),
                _buildFilterChip(
                    ProjectType.other, 'Outros', CustomTheme.infoColor),
                if (_selectedFilter != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ActionChip(
                      label: const TextCustom('Limpar Filtros', fontSize: 14),
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
                      'Erro ao carregar projetos: ${error.toString()}',
                      fontSize: 16,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => store.getProjects(),
                      child: const TextCustom('Tentar novamente'),
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
                              ? 'Nenhum projeto encontrado para "$_searchTerm"'
                              : 'Nenhum projeto encontrado para o filtro selecionado',
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
                      final horizontalSpacing =
                          32.0; // Espaçamento horizontal fixo

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
                            return Center(
                              child: ProjectCardEnhanced(
                                project: filteredProjects[index],
                              ),
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
                  const TextCustom(
                    'Interessado em trabalhar comigo?',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => whatsAppOpen(context),
                    icon: const FaIcon(FontAwesomeIcons.whatsapp),
                    label: const TextCustom('Entre em contato'),
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
