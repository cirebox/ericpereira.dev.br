import 'package:flutter/material.dart';

import 'footer.dart';
import 'header.dart';
import 'menu.dart';

class LayoutPage extends StatefulWidget {
  final Widget child;
  const LayoutPage({required this.child, super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  final GlobalKey<ScaffoldState> _sKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sKey,
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: const [
        Footer(),
      ],
      endDrawer: const Drawer(child: Menu()),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  header(_sKey),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: widget.child,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
