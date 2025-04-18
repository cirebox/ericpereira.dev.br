import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/openwhatsapp.service.dart';
import 'snackbar/snackbar.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  // Função unificada para abrir links
  Future<void> _launchUrl(BuildContext context, String url, String name) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        // ignore: use_build_context_synchronously
        snackBarWarning('Não foi possível acessar a página', context: context);
        throw 'Could not launch $url';
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      snackBarWarning('Erro ao abrir $name', context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // WhatsApp
        SocialButton(
          icon: FontAwesomeIcons.whatsapp,
          tooltip: 'WhatsApp',
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.green[400]
              : Colors.green[700],
          onPressed: () => whatsAppOpen(context),
          semanticLabel: 'Abrir WhatsApp para contato',
        ),

        // LinkedIn
        SocialButton(
          icon: FontAwesomeIcons.linkedin,
          tooltip: 'LinkedIn',
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.blue[400]
              : Colors.blue[800],
          onPressed: () => _launchUrl(
              context, 'https://www.linkedin.com/in/cire/', 'LinkedIn'),
          semanticLabel: 'Visitar perfil no LinkedIn',
        ),

        // GitHub
        SocialButton(
          icon: FontAwesomeIcons.github,
          tooltip: 'GitHub',
          color: Theme.of(context).textTheme.titleMedium!.color,
          onPressed: () =>
              _launchUrl(context, 'https://github.com/cirebox/', 'GitHub'),
          semanticLabel: 'Visitar perfil no GitHub',
        ),
      ],
    );
  }
}

class SocialButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final Color? color;
  final VoidCallback onPressed;
  final String semanticLabel;

  const SocialButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    required this.semanticLabel,
    this.color,
  });

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel,
      button: true,
      enabled: true,
      child: Tooltip(
        message: widget.tooltip,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: _isHovering
                ? Matrix4.translationValues(0, -5, 0)
                : Matrix4.identity(),
            child: IconButton(
              onPressed: widget.onPressed,
              hoverColor: Colors.transparent,
              splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
              icon: FaIcon(
                widget.icon,
                size: 25,
                color: widget.color ??
                    Theme.of(context).textTheme.titleMedium!.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
