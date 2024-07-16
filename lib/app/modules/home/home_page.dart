import 'package:flutter/material.dart';
import '../../shared/widgets/footer.dart';
import '../../shared/widgets/header.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Home'}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        persistentFooterAlignment: AlignmentDirectional.bottomCenter,
        persistentFooterButtons: const [
          Footer(),
        ],
        appBar: header(),
        body: Container(),
      ),
    );
  }
}
