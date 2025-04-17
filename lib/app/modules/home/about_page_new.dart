import 'package:ericpereira/app/modules/home/widgets/profile.dart';
import 'package:flutter/material.dart';
import '../../shared/widgets/layout_page.dart';
import '../../shared/models/post_model.dart';
import 'widgets/description.dart';
import 'widgets/news_section.dart';

class AboutPage extends StatefulWidget {
  final String title;
  const AboutPage({Key? key, this.title = 'Sobre'}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  // Lista de posts para alimentar a seção de novidades dinamicamente
  final List<PostModel> _recentPosts = const [
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              height: 0.2,
              color: Colors.grey,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Profile(),
                Description(),
              ],
            ),
          ),

          // Usar o novo componente NewsSection com dados dinâmicos
          NewsSection(
            posts: _recentPosts,
            title: 'Novidades',
            titleFontSize: 24,
          ),
        ],
      ),
    );
  }
}
