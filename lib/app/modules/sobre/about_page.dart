import 'package:ericpereira/app/shared/widgets/layout_page.dart';
import 'package:ericpereira/app/shared/widgets/menu.dart';
import 'package:ericpereira/app/shared/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../shared/services/openwhatsapp.service.dart';
import '../../shared/widgets/footer.dart';
import '../../shared/widgets/header.dart';
import '../../shared/widgets/snackbar/snackbar.dart';

class AboutPage extends StatefulWidget {
  final String title;
  const AboutPage({Key? key, this.title = 'Home'}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutPage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Sobre',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              height: 0.5,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        maxRadius: 100,
                        backgroundImage: NetworkImage(
                            'https://lh3.googleusercontent.com/a/ACg8ocKxE2wUkMPnMyQYmC1UrSKj-SBd79JVEq8asZOwAmy9ijGOVv091w=s288-c-no'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextCustom(
                        'Eric Pereira',
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const TextCustom(
                        'Full Stack Developer',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
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
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
                                ),
                              ),
                            ),
                            Tooltip(
                              message: 'Linkedin',
                              child: IconButton(
                                onPressed: () async {
                                  const url =
                                      'https://www.linkedin.com/in/cire/';
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(Uri.parse(url));
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    snackBarWarning(
                                        'Não foi possível acessar a página',
                                        context: context);
                                    throw 'Could not launch $url';
                                  }
                                },
                                hoverColor: Colors.transparent,
                                icon: FaIcon(
                                  FontAwesomeIcons.linkedin,
                                  size: 25,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
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
                                    snackBarWarning(
                                        'Não foi possível acessar a página',
                                        context: context);
                                    throw 'Could not launch $url';
                                  }
                                },
                                hoverColor: Colors.transparent,
                                icon: FaIcon(
                                  FontAwesomeIcons.github,
                                  size: 25,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
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
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextCustom(
                          '''Sou Técnico em Informática e graduado em Análise e Desenvolvimento de Sistemas pela Estácio, atuando como desenvolvedor há alguns anos. Minha principal ferramenta de trabalho é o Node.js. Embora tenha conhecimento em desenvolvimento front-end, optei por me especializar no back-end, especialmente no ecossistema do Node.js.\n
Tenho experiência em desenvolvimento de aplicações robustas e escaláveis, além de boas práticas de programação, como testes automatizados e integração contínua. Minha jornada profissional inclui colaboração em diversos projetos, desde startups até grandes empresas, sempre buscando entregar soluções eficientes e de alta qualidade.\n
Atualmente, estou consolidando meu conhecimento em Node.js, Next.js e Flutter, com o objetivo de ampliar minha expertise e contribuir ainda mais para projetos inovadores e desafiadores. 🚀''',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          textHeight: 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
