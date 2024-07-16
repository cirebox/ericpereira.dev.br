import 'package:flutter/material.dart';

import 'button_theme.dart';
import 'logo.dart';
import 'menu.dart';

PreferredSizeWidget header() {
  return const PreferredSize(
    preferredSize: Size.fromHeight(120),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Logo(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Menu(),
                ButtonThemeWidget(),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
