import 'package:flutter/material.dart';

class CustomTheme with ChangeNotifier {
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  static bool _isDarkTheme = false;
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static double get fontSizeTitleMedium => 28;

  static ThemeData get lightTheme => ThemeData(
        scaffoldBackgroundColor: Colors.white,
        dividerColor: Colors.transparent,
        cardColor: Colors.white,
        fontFamily: 'Nunito',
        textTheme: lightTextTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.only(right: 30, left: 15, top: 15),
          horizontalTitleGap: 15,
          minVerticalPadding: 10,
          style: ListTileStyle.list,
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 6,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        scaffoldBackgroundColor: Colors.black,
        dividerColor: Colors.transparent,
        cardColor: Colors.white,
        fontFamily: 'Nunito',
        textTheme: darkTextTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.only(right: 30, left: 15, top: 15),
          horizontalTitleGap: 15,
          minVerticalPadding: 10,
          style: ListTileStyle.list,
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 6,
        ),
      );

  static TextTheme get lightTextTheme => TextTheme(
        titleMedium: TextStyle(
          fontSize: fontSizeTitleMedium,
          color: Colors.black,
        ),
      );

  static TextTheme get darkTextTheme => ThemeData.dark().textTheme.copyWith(
        titleMedium: TextStyle(
          fontSize: fontSizeTitleMedium,
          color: Colors.white,
        ),
      );
}
