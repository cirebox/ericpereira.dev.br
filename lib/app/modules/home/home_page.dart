import 'package:flutter/material.dart';
import '../../shared/widgets/layout_page.dart';
import '../../shared/models/post_model.dart';
import 'sections/about_section.dart';
import 'sections/news_landing_section.dart';
import 'sections/contact_section.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Home'}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista de posts para alimentar a seção de novidades dinamicamente
  final List<PostModel> _recentPosts = const [
    PostModel(
      date: '17/04/2025',
      title: 'Atualização do portfólio',
      detail: 'Confira os novos projetos adicionados ao portfólio.',
      url: '/portfolio',
    ),
    PostModel(
      date: '17/07/2023',
      title: 'Lançamento do site CireBox',
      detail: 'Lançamento do novo site da empresa cirebox, venha conferir.',
      url: 'https://cirebox.com.br/',
    ),
    PostModel(
      date: '03/07/2023',
      title: 'Lançamento do site da Saaetri',
      detail: 'O site da saaetri esta de cara nova venha conferir.',
      url: 'https://saaetri.com.br/',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutPage(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),

              // Seção Sobre
              const AboutSection(),

              // Seção Novidades
              NewsLandingSection(posts: _recentPosts),

              // Seção Contato
              const ContactSection(),
            ],
          ),
        ),
      ),
    );
  }
}
