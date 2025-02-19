import 'package:ericpereira/app/modules/sobre/widgets/perfil.dart';
import 'package:flutter/material.dart';
import '../../shared/widgets/layout_page.dart';
import '../../shared/widgets/text_custom.dart';
import 'widgets/description.dart';

class AboutPage extends StatefulWidget {
  final String title;
  const AboutPage({Key? key, this.title = 'Sobre'}) : super(key: key);

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
          const Align(
            alignment: Alignment.centerLeft,
            child: TextCustom(
              'Sobre',
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
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Profile(),
                Description(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
