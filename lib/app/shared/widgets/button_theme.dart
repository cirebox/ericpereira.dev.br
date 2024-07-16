import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme.config.dart';
import '../../theme/theme.custom.app.dart';

class ButtonThemeWidget extends StatefulWidget {
  const ButtonThemeWidget({super.key});

  @override
  State<ButtonThemeWidget> createState() => _ButtonThemeWidgetState();
}

class _ButtonThemeWidgetState extends State<ButtonThemeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: IconButton(
        onPressed: () {
          Provider.of<CustomTheme>(context, listen: false).toggleTheme();
        },
        hoverColor: Colors.transparent,
        icon: Icon(
          currentTheme.currentTheme == ThemeMode.dark
              ? Icons.light_mode
              : Icons.dark_mode,
          color: Theme.of(context).textTheme.titleMedium!.color,
          size: 25,
        ),
      ),
    );
  }
}
