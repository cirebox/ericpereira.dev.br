import 'package:flutter/material.dart';
import '../../../shared/widgets/text_custom.dart';

class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              textAlign: TextAlign.start,
              textScaleFactor: 0.8,
              softWrap: true,
              text: TextSpan(
                children: [
                  TextSpanCustom(
                    'Sou desenvolvedor graduado em Análise Desenvolvimento de Sistemas pela ',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    textHeight: 1.2,
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                  TextSpanCustom(
                    'Estácio',
                    href: 'https://estacio.br/',
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    textHeight: 1.2,
                  ),
                  TextSpanCustom(
                    ', proprietário da empresa ',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    textHeight: 1.2,
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                  TextSpanCustom(
                    'Cirebox',
                    href: 'https://cirebox.com.br/',
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    textHeight: 1.2,
                  ),
                  TextSpanCustom(
                    ' e pai de família.\n\nTrabalho com desenvolvimento há alguns anos, comecei minha carreira profissional aos 18 anos de idade, como desenvolvedor desktop utilizando Delphi, para contrução de aplicações. Logo depois comecei a estudar php, html e css, e fui desenvolvendo minhas primeiras aplicações web.\n\n',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    textHeight: 1.2,
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                  TextSpanCustom(
                    'Tenho experiência em desenvolvimento de aplicações robustas e escaláveis, além de boas práticas de programação, como testes automatizados e integração contínua. Minha jornada profissional inclui colaboração em diversos projetos, desde startups a grandes empresas, sempre buscando entregar soluções eficientes e de alta qualidade.\n\n',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    textHeight: 1.2,
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                  TextSpanCustom(
                    'Atualmente, estou consolidando meu conhecimento em ',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    textHeight: 1.2,
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                  TextSpanCustom(
                    'Node',
                    href: 'https://nodejs.org/pt',
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    textHeight: 1.2,
                  ),
                  TextSpanCustom(
                    ' e ',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    textHeight: 1.2,
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                  TextSpanCustom(
                    'Flutter',
                    href: 'https://flutter.dev/',
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    textHeight: 1.2,
                  ),
                  TextSpanCustom(
                    ', com o objetivo de ampliar minha expertise e contribuir ainda mais para projetos inovadores e desafiadores. 🚀\n\n',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    textHeight: 1.2,
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
