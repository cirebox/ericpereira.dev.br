import 'package:ericpereira/app/shared/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/widgets/snackbar/snackbar.dart';
import '../../domain/entities/project.entity.dart';

class ProjectCardEnhanced extends StatefulWidget {
  final ProjectEntity project;

  const ProjectCardEnhanced({
    required this.project,
    super.key,
  });

  @override
  State<ProjectCardEnhanced> createState() => _ProjectCardEnhancedState();
}

class _ProjectCardEnhancedState extends State<ProjectCardEnhanced>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuint),
    );

    _elevationAnimation = Tween<double>(begin: 2, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuint),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchURL(String? url, BuildContext context) async {
    if (url != null) {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        // ignore: use_build_context_synchronously
        snackBarWarning('Não foi possível acessar a página', context: context);
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final projectTypeColors = {
      ProjectType.website: const Color(0xFF38B2AC),
      ProjectType.app: const Color(0xFF4299E1),
      ProjectType.websystem: const Color(0xFF805AD5),
      ProjectType.apirest: const Color(0xFFED8936),
      ProjectType.software: const Color(0xFFE53E3E),
      ProjectType.other: const Color(0xFF718096),
    };

    final projectTypeColor =
        projectTypeColors[widget.project.type] ?? const Color(0xFF718096);

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 330,
              height: 420,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered
                        ? projectTypeColor.withOpacity(0.2)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: _elevationAnimation.value * 2,
                    spreadRadius: _isHovered ? 0 : -2,
                    offset: Offset(0, _isHovered ? 4 : 2),
                  ),
                ],
                border: Border.all(
                  color: _isHovered
                      ? projectTypeColor.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.1),
                  width: _isHovered ? 1.5 : 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Imagem do projeto com overlay de informações ao passar o mouse
                  Stack(
                    children: [
                      Hero(
                        tag: 'project-${widget.project.name}',
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: SizedBox(
                            // MELHORIA: Aumentada a altura da imagem para 200px
                            height: 200,
                            width: double.infinity,
                            child: Image.asset(
                              widget.project.imageUrl,
                              // MELHORIA: BoxFit permanece como cover, mas o alinhamento foi alterado
                              // para topCenter para melhor visualização de logotipos
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              // MELHORIA: Tratamento de erro aprimorado com mensagem mais clara
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: projectTypeColor.withOpacity(0.05),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.image_not_supported_outlined,
                                          color:
                                              projectTypeColor.withOpacity(0.3),
                                          size: 40,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Imagem não disponível',
                                          style: TextStyle(
                                            color: projectTypeColor
                                                .withOpacity(0.6),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              // MELHORIA: Efeito de carregamento mais suave
                              frameBuilder: (context, child, frame,
                                  wasSynchronouslyLoaded) {
                                if (wasSynchronouslyLoaded) return child;
                                return AnimatedOpacity(
                                  opacity: frame == null ? 0 : 1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOutCubic,
                                  child: child,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      // Overlay ao passar o mouse - ajustado para a nova altura
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: _isHovered ? 1.0 : 0.0,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: Container(
                            // MELHORIA: Altura ajustada para combinar com a imagem
                            height: 200,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  projectTypeColor.withOpacity(0.7),
                                  projectTypeColor.withOpacity(0.9),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (widget.project.urlDemo != null)
                                    _buildActionButton(
                                      Icons.language,
                                      'Visitar site',
                                      () => _launchURL(
                                          widget.project.urlDemo, context),
                                    ),
                                  if (widget.project.githubUrl != null)
                                    _buildActionButton(
                                      FontAwesomeIcons.github,
                                      'Ver código',
                                      () => _launchURL(
                                          widget.project.githubUrl, context),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Chip de tipo de projeto no canto superior
                      Positioned(
                        top: 12,
                        right: 12,
                        child: _buildProjectTypeChip(
                            widget.project.type, projectTypeColor),
                      ),
                    ],
                  ),

                  // Conteúdo do card
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Título do projeto
                          TextCustom(
                            widget.project.name,
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 10),

                          // Cliente
                          if (widget.project.client != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.business,
                                    size: 14,
                                    color: projectTypeColor.withOpacity(0.7),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: TextCustom(
                                      widget.project.client!,
                                      fontSize: 13,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // Descrição
                          if (widget.project.description != null)
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: TextCustom(
                                  widget.project.description!,
                                  fontSize: 13,
                                  color: Colors.black54,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),

                          // Tecnologias
                          if (widget.project.stack != null &&
                              widget.project.stack!.isNotEmpty)
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: widget.project.stack!
                                  .take(4)
                                  .map((tech) =>
                                      _buildTechChip(tech, projectTypeColor))
                                  .toList(),
                            ),

                          const Spacer(),

                          // Data de lançamento
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 12,
                                color: projectTypeColor.withOpacity(0.6),
                              ),
                              const SizedBox(width: 6),
                              TextCustom(
                                'Lançado em ${widget.project.launch}',
                                color: Colors.black45,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, String tooltip, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(50),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: Colors.black87,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 8),
                TextCustom(
                  tooltip,
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectTypeChip(ProjectType type, Color color) {
    String label;

    switch (type) {
      case ProjectType.app:
        label = 'App';
        break;
      case ProjectType.website:
        label = 'Website';
        break;
      case ProjectType.websystem:
        label = 'Web System';
        break;
      case ProjectType.apirest:
        label = 'API Rest';
        break;
      case ProjectType.software:
        label = 'Software';
        break;
      default:
        label = 'Outro';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 6),
          TextCustom(
            label,
            fontSize: 11,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget _buildTechChip(String tech, Color baseColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: baseColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: baseColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: TextCustom(
        tech,
        fontSize: 11,
        color: baseColor.withOpacity(0.9),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
