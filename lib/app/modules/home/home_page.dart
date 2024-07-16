import 'package:ericpereira/app/shared/widgets/menu.dart';
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
  final GlobalKey<ScaffoldState> _sKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _sKey,
        persistentFooterAlignment: AlignmentDirectional.bottomCenter,
        persistentFooterButtons: const [
          Footer(),
        ],
        endDrawerEnableOpenDragGesture: true,
        endDrawer: const Drawer(child: Menu()),
        appBar: header(_sKey),
        body: Container(),
      ),
    );
  }
}
