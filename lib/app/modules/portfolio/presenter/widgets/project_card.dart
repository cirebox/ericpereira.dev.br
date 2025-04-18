import 'package:ericpereira/app/shared/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/widgets/snackbar/snackbar.dart';
import '../../domain/entities/project.entity.dart';

class ProjectCard extends StatefulWidget {
  final ProjectEntity project;

  const ProjectCard({
    required this.project,
    super.key,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

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
    final primaryColor = Theme.of(context).primaryColor;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuint,
        width: 330,
        height: 420,
        transform: _isHovered 
            ? (Matrix4.identity()..translate(0, -8, 0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.05),
              spreadRadius: _isHovered ? 0 : 0,
              blurRadius: _isHovered ? 24 : 8,
              offset: Offset(0, _isHovered ? 8 : 2),
            ),
          ],
          border: Border.all(
            color: _isHovered 
                ? primaryColor.withOpacity(0.2)
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
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: AssetImage(widget.project.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (_isHovered)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        color: Colors.black.withOpacity(0.7),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.project.urlDemo != null)
                              IconButton(
                                icon: const Icon(
                                  Icons.link,
                                  color: Colors.white,
                                  size: 26,
                                ),
                                onPressed: () {
                                  _launchURL(widget.project.urlDemo, context);
                                },
                                tooltip: 'Visite o site',
                              ),
                            if (widget.project.githubUrl != null)
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: IconButton(
                                  icon: const FaIcon(
                                    FontAwesomeIcons.github,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                  onPressed: () {
                                    _launchURL(
                                        widget.project.githubUrl, context);
                                  },
                                  tooltip: 'Ver código no GitHub',
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ), // Informações do projeto
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextCustom(
                            widget.project.name,
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildProjectTypeChip(widget.project.type),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (widget.project.client != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.business,
                              size: 14,
                              color: Colors.black45,
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: TextCustom(
                                '${widget.project.client}',
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
                    if (widget.project.description != null)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextCustom(
                            widget.project.description!,
                            fontSize: 13,
                            color: Colors.black54,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ), // Stack de tecnologias
                    if (widget.project.stack != null &&
                        widget.project.stack!.isNotEmpty)
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: widget.project.stack!
                            .take(4)
                            .map((tech) => _buildTechChip(tech))
                            .toList(),
                      ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                          color: Colors.black38,
                        ),
                        SizedBox(width: 4),
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
  }

  Widget _buildProjectTypeChip(ProjectType type) {
    Color chipColor;
    String label;

    switch (type) {
      case ProjectType.app:
        chipColor = Colors.blue;
        label = 'App';
        break;
      case ProjectType.website:
        chipColor = Colors.green;
        label = 'Website';
        break;
      case ProjectType.websystem:
        chipColor = Colors.purple;
        label = 'Web System';
        break;
      case ProjectType.apirest:
        chipColor = Colors.orange;
        label = 'API Rest';
        break;
      case ProjectType.software:
        chipColor = Colors.red;
        label = 'Software';
        break;
      default:
        chipColor = Colors.grey;
        label = 'Outro';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: chipColor.withOpacity(0.5)),
      ),
      child: TextCustom(
        label,
        fontSize: 12,
        color: chipColor.withOpacity(0.8),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTechChip(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: TextCustom(
        tech,
        fontSize: 11,
        color: Colors.black54,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
