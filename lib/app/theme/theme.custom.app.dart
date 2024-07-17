import 'package:flutter/material.dart';

class CustomTheme with ChangeNotifier {
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  static bool _isDarkTheme = false;
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static double get fontSizeTitleMedium => 28;
  static Color? get fontColorLight => Colors.black;
  static Color? get fontColorDark => Colors.white;

  static ThemeData get lightTheme => ThemeData(
        scaffoldBackgroundColor: Colors.white,
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.white.withOpacity(0.9),
        ),
        dividerColor: Colors.transparent,
        cardColor: Colors.white,
        fontFamily: 'Nunito',
        textTheme: lightTextTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: fontColorLight),
          elevation: 0,
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.only(right: 30, left: 15, top: 15),
          horizontalTitleGap: 15,
          minVerticalPadding: 10,
          style: ListTileStyle.list,
        ),
        cardTheme: CardTheme(
          color: Colors.white.withOpacity(0.9),
          elevation: 2,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        scaffoldBackgroundColor: Colors.black.withOpacity(0.8),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
        dividerColor: Colors.transparent,
        cardColor: Colors.white,
        fontFamily: 'Nunito',
        textTheme: darkTextTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: fontColorDark),
          elevation: 0,
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.only(right: 30, left: 15, top: 15),
          horizontalTitleGap: 15,
          minVerticalPadding: 10,
          style: ListTileStyle.list,
        ),
        cardTheme: CardTheme(
          color: Colors.white.withOpacity(0.9),
          elevation: 2,
        ),
      );

  static TextTheme get lightTextTheme => TextTheme(
        titleMedium: TextStyle(
          fontSize: fontSizeTitleMedium,
          color: fontColorLight,
        ),
      );

  static TextTheme get darkTextTheme => ThemeData.dark().textTheme.copyWith(
        titleMedium: TextStyle(
          fontSize: fontSizeTitleMedium,
          color: fontColorDark,
        ),
      );
}
