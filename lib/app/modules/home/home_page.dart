import 'package:flutter/material.dart';

import '../../shared/widgets/layout_page.dart';
import 'sections/about_section.dart';
import 'sections/news_section.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Home'}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const LayoutPage(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Seção Sobre (section 1) - mais compacta
            AboutSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
      child: Container(
        height: 0.5,
        color: Colors.grey.withOpacity(0.5),
      ),
    );
  }
}
