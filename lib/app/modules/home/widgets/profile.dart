import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/services/openwhatsapp.service.dart';
import '../../../shared/widgets/snackbar/snackbar.dart';
import '../../../shared/widgets/text_custom.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
    // Usar MediaQuery para responsividade
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          // Hero animation para a imagem de perfil
          Hero(
            tag: 'profile-image',
            child: Container(
              width: isSmallScreen ? 150 : 200,
              height: isSmallScreen ? 150 : 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  // Usar imagem local dos assets (você precisará adicionar esta imagem aos assets)
                  image: const AssetImage('assets/images/profile.png'),
                  // Fallback para a imagem remota caso a local não esteja disponível
                  onError: (error, stackTrace) {
                    debugPrint('Error loading profile image: $error');
                  },
                  // Using NetworkImage as a fallback is now handled in the errorBuilder of Image.asset
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextCustom(
            'Eric Pereira',
            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 8,
          ),
          const TextCustom(
            'Full Stack Developer',
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(
            height: 15,
          ),
          // Social media links com efeitos de hover
          SizedBox(
            width: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // WhatsApp
                _SocialButton(
                  icon: FontAwesomeIcons.whatsapp,
                  tooltip: 'WhatsApp',
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.green[400]
                      : Colors.green[700],
                  onPressed: () => whatsAppOpen(context),
                  semanticLabel: 'Abrir WhatsApp para contato',
                ),

                // LinkedIn
                _SocialButton(
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
                _SocialButton(
                  icon: FontAwesomeIcons.github,
                  tooltip: 'GitHub',
                  color: Theme.of(context).textTheme.titleMedium!.color,
                  onPressed: () => _launchUrl(
                      context, 'https://github.com/cirebox/', 'GitHub'),
                  semanticLabel: 'Visitar perfil no GitHub',
                ),

                // Botão cirebox comentado, mantido para referência futura
                // _SocialButton(
                //   icon: FontAwesomeIcons.computer,
                //   tooltip: 'Cirebox Web Site',
                //   color: Theme.of(context).textTheme.titleMedium!.color,
                //   onPressed: () => _launchUrl(
                //     context,
                //     'https://cirebox.com.br/',
                //     'Cirebox'
                //   ),
                //   semanticLabel: 'Visitar site da Cirebox',
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para padronizar os botões de redes sociais com efeitos de hover
class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final Color? color;
  final VoidCallback onPressed;
  final String semanticLabel;

  const _SocialButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    required this.semanticLabel,
    this.color,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
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
