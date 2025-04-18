import 'package:flutter/material.dart';

class CustomTheme with ChangeNotifier {
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  static bool _isDarkTheme =
      true; // Alterado para true para iniciar com tema escuro
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  // Paleta de cores principal
  static const Color primaryColor = Color(0xFF3182CE); // Azul mais vibrante
  static const Color secondaryColor = Color(0xFF805AD5); // Roxo moderno
  static const Color accentColor =
      Color(0xFF38B2AC); // Teal para elementos de destaque

  // Cores para feedback
  static const Color successColor = Color(0xFF38A169); // Verde para sucesso
  static const Color errorColor = Color(0xFFE53E3E); // Vermelho para erros
  static const Color warningColor = Color(0xFFDD6B20); // Laranja para avisos
  static const Color infoColor = Color(0xFF3182CE); // Azul para informações

  // Tipografia
  static const String fontFamily = 'Nunito';
  static double get fontSizeTitleLarge => 32;
  static double get fontSizeTitleMedium => 28;
  static double get fontSizeTitleSmall => 20;
  static double get fontSizeBodyLarge => 16;
  static double get fontSizeBodyMedium => 14;
  static double get fontSizeBodySmall => 12;

  // Cores de texto
  static Color get fontColorLight => const Color(0xFF1A202C);
  static Color get fontColorLightSecondary => const Color(0xFF4A5568);
  static Color get fontColorDark => const Color(0xFFF7FAFC);
  static Color get fontColorDarkSecondary => const Color(0xFFCBD5E0);

  // Bordas arredondadas
  static double get borderRadiusSmall => 4;
  static double get borderRadiusMedium => 8;
  static double get borderRadiusLarge => 16;
  static double get borderRadiusXLarge => 24;

  // Espaçamentos
  static double get spacingXSmall => 4;
  static double get spacingSmall => 8;
  static double get spacingMedium => 16;
  static double get spacingLarge => 24;
  static double get spacingXLarge => 32;

  static ThemeData get lightTheme => ThemeData(
        // Cores principais
        primaryColor: primaryColor,
        primaryColorLight: primaryColor.withOpacity(0.7),
        primaryColorDark: const Color(0xFF2C5282),
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          tertiary: accentColor,
          error: errorColor,
          surface: Colors.white,
          background: const Color(0xFFF7FAFC),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: fontColorLight,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7FAFC),

        // Elementos de UI
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(borderRadiusLarge),
              bottomRight: Radius.circular(borderRadiusLarge),
            ),
          ),
          elevation: 8,
        ),
        dividerColor: const Color(0xFFE2E8F0),
        dividerTheme: const DividerThemeData(
          color: Color(0xFFE2E8F0),
          thickness: 1,
          space: 16,
        ),
        cardColor: Colors.white,
        fontFamily: fontFamily,

        // Tipografia
        textTheme: lightTextTheme,

        // Densidade visual
        visualDensity: VisualDensity.adaptivePlatformDensity,

        // Barra de navegação
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: fontColorLight,
          iconTheme: IconThemeData(color: fontColorLight),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: fontSizeTitleSmall,
            fontWeight: FontWeight.bold,
            color: fontColorLight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(borderRadiusSmall),
            ),
          ),
        ),

        // Lista
        listTileTheme: ListTileThemeData(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          horizontalTitleGap: 16,
          minVerticalPadding: 12,
          style: ListTileStyle.list,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusMedium),
          ),
          tileColor: Colors.white,
          selectedTileColor: primaryColor.withOpacity(0.1),
          iconColor: primaryColor,
          textColor: fontColorLight,
        ),

        // Cards
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusMedium),
          ),
          shadowColor: Colors.black.withOpacity(0.1),
          margin: EdgeInsets.all(spacingSmall),
        ),

        // Botões
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusMedium),
            ),
            elevation: 2,
            textStyle: TextStyle(
              fontFamily: fontFamily,
              fontSize: fontSizeBodyMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            side: BorderSide(color: primaryColor, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusMedium),
            ),
            textStyle: TextStyle(
              fontFamily: fontFamily,
              fontSize: fontSizeBodyMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            textStyle: TextStyle(
              fontFamily: fontFamily,
              fontSize: fontSizeBodyMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Campos de input
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusMedium),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusMedium),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusMedium),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusMedium),
            borderSide: BorderSide(color: errorColor, width: 1),
          ),
          labelStyle: TextStyle(
            color: fontColorLightSecondary,
            fontSize: fontSizeBodyMedium,
            fontWeight: FontWeight.normal,
          ),
          hintStyle: TextStyle(
            color: fontColorLightSecondary.withOpacity(0.7),
            fontSize: fontSizeBodyMedium,
          ),
        ),

        // Switches, checkboxes, radio buttons
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) return primaryColor;
            return Colors.grey;
          }),
          trackColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected))
              return primaryColor.withOpacity(0.5);
            return Colors.grey.withOpacity(0.3);
          }),
        ),

        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) return primaryColor;
            return Colors.transparent;
          }),
          checkColor: MaterialStateProperty.all(Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusSmall),
          ),
          side: BorderSide(color: fontColorLightSecondary),
        ),

        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) return primaryColor;
            return fontColorLightSecondary;
          }),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        // Cores principais
        primaryColor: primaryColor,
        primaryColorLight: primaryColor.withOpacity(0.7),
        primaryColorDark: const Color(0xFF2C5282),
        colorScheme: ColorScheme.dark(
          primary: primaryColor,
          secondary: secondaryColor,
          tertiary: accentColor,
          error: errorColor,
          surface: const Color(0xFF2D3748),
          background: const Color(0xFF171923),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: fontColorDark,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF1A202C),

        // Elementos de UI
        drawerTheme: DrawerThemeData(
          backgroundColor: const Color(0xFF2D3748),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(borderRadiusLarge),
              bottomRight: Radius.circular(borderRadiusLarge),
            ),
          ),
          elevation: 8,
        ),
        dividerColor: const Color(0xFF4A5568),
        dividerTheme: const DividerThemeData(
          color: Color(0xFF4A5568),
          thickness: 1,
          space: 16,
        ),
        cardColor: const Color(0xFF2D3748),
        fontFamily: fontFamily,

        // Tipografia
        textTheme: darkTextTheme,

        // Densidade visual
        visualDensity: VisualDensity.adaptivePlatformDensity,

        // Barra de navegação
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF2D3748),
          foregroundColor: fontColorDark,
          iconTheme: IconThemeData(color: fontColorDark),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: fontSizeTitleSmall,
            fontWeight: FontWeight.bold,
            color: fontColorDark,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(borderRadiusSmall),
            ),
          ),
        ),

        // Lista
        listTileTheme: ListTileThemeData(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          horizontalTitleGap: 16,
          minVerticalPadding: 12,
          style: ListTileStyle.list,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusMedium),
          ),
          tileColor: const Color(0xFF2D3748),
          selectedTileColor: primaryColor.withOpacity(0.2),
          iconColor: primaryColor.withOpacity(0.9),
          textColor: fontColorDark,
        ),

        // Cards
        cardTheme: CardTheme(
          color: const Color(0xFF2D3748),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusMedium),
          ),
          shadowColor: Colors.black.withOpacity(0.3),
          margin: EdgeInsets.all(spacingSmall),
        ),

        // Botões
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusMedium),
            ),
            elevation: 4,
            textStyle: TextStyle(
              fontFamily: fontFamily,
              fontSize: fontSizeBodyMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor.withOpacity(0.9),
            side: BorderSide(color: primaryColor.withOpacity(0.9), width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusMedium),
            ),
            textStyle: TextStyle(
              fontFamily: fontFamily,
              fontSize: fontSizeBodyMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor.withOpacity(0.9),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            textStyle: TextStyle(
              fontFamily: fontFamily,
              fontSize: fontSizeBodyMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Campos de input
        inputDecorationTheme: InputDecorationTheme(
          fillColor: const Color(0xFF2D3748),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusMedium),
            borderSide: const BorderSide(color: Color(0xFF4A5568), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusMedium),
            borderSide: const BorderSide(color: Color(0xFF4A5568), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusMedium),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusMedium),
            borderSide: BorderSide(color: errorColor, width: 1),
          ),
          labelStyle: TextStyle(
            color: fontColorDarkSecondary,
            fontSize: fontSizeBodyMedium,
            fontWeight: FontWeight.normal,
          ),
          hintStyle: TextStyle(
            color: fontColorDarkSecondary.withOpacity(0.7),
            fontSize: fontSizeBodyMedium,
          ),
        ),

        // Switches, checkboxes, radio buttons
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) return primaryColor;
            return const Color(0xFF718096);
          }),
          trackColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected))
              return primaryColor.withOpacity(0.5);
            return const Color(0xFF4A5568);
          }),
        ),

        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) return primaryColor;
            return Colors.transparent;
          }),
          checkColor: MaterialStateProperty.all(Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusSmall),
          ),
          side: BorderSide(color: fontColorDarkSecondary),
        ),

        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) return primaryColor;
            return fontColorDarkSecondary;
          }),
        ),
      );

  static TextTheme get lightTextTheme => TextTheme(
        // Títulos
        displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: fontColorLight,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: fontColorLight,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: fontColorLight,
        ),
        headlineLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: fontColorLight,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: fontColorLight,
        ),
        headlineSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: fontColorLight,
        ),
        titleLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: fontColorLight,
        ),
        titleMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: fontColorLight,
        ),
        titleSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: fontColorLight,
        ),
        // Corpo do texto
        bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: fontColorLightSecondary,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: fontColorLightSecondary,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: fontColorLightSecondary,
          height: 1.5,
        ),
        // Outros
        labelLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: fontColorLight,
        ),
        labelMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: fontColorLight,
        ),
        labelSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: fontColorLightSecondary,
          letterSpacing: 0.5,
        ),
      );

  static TextTheme get darkTextTheme => TextTheme(
        // Títulos
        displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: fontColorDark,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: fontColorDark,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: fontColorDark,
        ),
        headlineLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: fontColorDark,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: fontColorDark,
        ),
        headlineSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: fontColorDark,
        ),
        titleLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: fontColorDark,
        ),
        titleMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: fontColorDark,
        ),
        titleSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: fontColorDark,
        ),
        // Corpo do texto
        bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: fontColorDarkSecondary,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: fontColorDarkSecondary,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: fontColorDarkSecondary,
          height: 1.5,
        ),
        // Outros
        labelLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: fontColorDark,
        ),
        labelMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: fontColorDark,
        ),
        labelSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: fontColorDarkSecondary,
          letterSpacing: 0.5,
        ),
      );
}
