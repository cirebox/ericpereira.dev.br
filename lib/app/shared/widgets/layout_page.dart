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
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _sKey = GlobalKey();

  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 200 && !_isScrolled) {
        setState(() {
          _isScrolled = true;
        });
      } else if (_scrollController.offset <= 200 && _isScrolled) {
        setState(() {
          _isScrolled = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      _isScrolled = false;
    });
  }

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
        controller: _scrollController,
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
      floatingActionButton: Visibility(
        visible: _isScrolled,
        child: FloatingActionButton(
          backgroundColor: Colors.black45,
          elevation: 1,
          onPressed: () {
            _scrollToTop();
          },
          child: const Icon(
            Icons.arrow_upward_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
