import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/services/openwhatsapp.service.dart';
import '../../../shared/widgets/snackbar/snackbar.dart';
import '../../../shared/widgets/text_custom.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          const CircleAvatar(
            maxRadius: 100,
            backgroundImage: NetworkImage(
                'https://media.licdn.com/dms/image/D4D03AQF2A2iQYXTw_g/profile-displayphoto-shrink_200_200/0/1713559177151?e=1726704000&v=beta&t=IfXvsc-Ix8vc2CK4eDhty0gVldhx6A16dIEiYnqSQcM'),
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
          SizedBox(
            width: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Tooltip(
                  message: 'WhatsApp',
                  child: IconButton(
                    onPressed: () => whatsAppOpen(context),
                    hoverColor: Colors.transparent,
                    icon: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      size: 25,
                      color: Theme.of(context).textTheme.titleMedium!.color,
                    ),
                  ),
                ),
                Tooltip(
                  message: 'Linkedin',
                  child: IconButton(
                    onPressed: () async {
                      const url = 'https://www.linkedin.com/in/cire/';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        // ignore: use_build_context_synchronously
                        snackBarWarning('Não foi possível acessar a página',
                            context: context);
                        throw 'Could not launch $url';
                      }
                    },
                    hoverColor: Colors.transparent,
                    icon: FaIcon(
                      FontAwesomeIcons.linkedin,
                      size: 25,
                      color: Theme.of(context).textTheme.titleMedium!.color,
                    ),
                  ),
                ),
                Tooltip(
                  message: 'GitHub',
                  child: IconButton(
                    onPressed: () async {
                      const url = 'https://github.com/cirebox/';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        // ignore: use_build_context_synchronously
                        snackBarWarning('Não foi possível acessar a página',
                            context: context);
                        throw 'Could not launch $url';
                      }
                    },
                    hoverColor: Colors.transparent,
                    icon: FaIcon(
                      FontAwesomeIcons.github,
                      size: 25,
                      color: Theme.of(context).textTheme.titleMedium!.color,
                    ),
                  ),
                ),
                // Tooltip(
                //   message: 'Cirebox Web Site',
                //   child: IconButton(
                //     onPressed: () async {
                //       const url = 'https://cirebox.com.br/';
                //       if (await canLaunchUrl(Uri.parse(url))) {
                //         await launchUrl(Uri.parse(url));
                //       } else {
                //         // ignore: use_build_context_synchronously
                //         snackBarWarning(
                //             'Não foi possível acessar a página',
                //             context: context);
                //         throw 'Could not launch $url';
                //       }
                //     },
                //     hoverColor: Colors.transparent,
                //     icon: FaIcon(
                //       FontAwesomeIcons.computer,
                //       size: 25,
                //       color: Theme.of(context)
                //           .textTheme
                //           .titleMedium!
                //           .color,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
