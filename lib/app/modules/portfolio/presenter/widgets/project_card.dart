import 'package:ericpereira/app/shared/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/widgets/snackbar/snackbar.dart';

class ProjectCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String launch;
  final String? urlDemo;
  const ProjectCard({
    required this.name,
    required this.imageUrl,
    required this.launch,
    this.urlDemo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (urlDemo != null) {
          if (await canLaunchUrl(Uri.parse(urlDemo!))) {
            await launchUrl(Uri.parse(urlDemo!));
          } else {
            // ignore: use_build_context_synchronously
            snackBarWarning('Não foi possível acessar a página',
                context: context);
            throw 'Could not launch $urlDemo';
          }
        }
      },
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            // border: Border.all(
            //   color: Colors.black.withOpacity(0.1),
            // ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 170,
              width: 280,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 100,
                    child: Image.asset(
                      imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: SizedBox(
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustom(
                            name,
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextCustom(
                            'Lançado em $launch',
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
