import 'package:ericpereira/app/shared/widgets/layout_page.dart';
import 'package:flutter/material.dart';

import '../../shared/widgets/text_custom.dart';
import '../../shared/widgets/posts_widgets.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Home'}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          const Align(
            alignment: Alignment.centerLeft,
            child: TextCustom(
              'Recentes',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
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
            child: Column(
              children: [
                PostWidget(
                  date: '17/07/2023',
                  title: 'Lançamento do site CireBox',
                  detail:
                      'Lançamento do novo site da empresa cirebox, venha conferir.',
                  url: 'https://cirebox.com.br/',
                ),
                PostWidget(
                  date: '03/07/2023',
                  title: 'Lançamento do site da Saaetri',
                  detail: 'O site da saaetri esta de cara nova venha conferir.',
                  url: 'https://saaetri.com.br/',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
