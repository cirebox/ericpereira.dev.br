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
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextCustom(
              '''Sou Técnico em Informática e graduado em Análise e Desenvolvimento de Sistemas pela Estácio. Trabalho com desenvolvimento há alguns anos, comecei minha carreira com 18 anos como desenvolvedor desktop utilizando Delphi, para contrução de aplicações. Logo depois tive meu primeiro contato com php e comecei a desenvolver minhas primeiras aplicações web.\n
Ao longo dos anos fui conhecendo novas tecnologias como Python, Java, Kotlin, React, Flutter, entre outras. Porém optei por me especializar no back-end, especialmente no ecossistema do Node.js.\n
Tenho experiência em desenvolvimento de aplicações robustas e escaláveis, além de boas práticas de programação, como testes automatizados e integração contínua. Minha jornada profissional inclui colaboração em diversos projetos, desde startups até grandes empresas, sempre buscando entregar soluções eficientes e de alta qualidade.\n
Atualmente, estou consolidando meu conhecimento em Node e Flutter, com o objetivo de ampliar minha expertise e contribuir ainda mais para projetos inovadores e desafiadores. 🚀''',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              textHeight: 1.2,
            ),
          ],
        ),
      ),
    );
  }
}
