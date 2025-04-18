import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import 'theme/theme.config.dart';
import 'theme/theme.custom.app.dart';
import 'shared/i18n/localization_service.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provedor para o tema
        ChangeNotifierProvider<CustomTheme>.value(
          value: currentTheme,
        ),
        // Provedor para internacionalização
        ChangeNotifierProvider<LocalizationService>.value(
          value: Modular.get<LocalizationService>(),
        ),
      ],
      child: Consumer2<CustomTheme, LocalizationService>(
        builder: (context, themeNotifier, localizationNotifier, child) {
          return MaterialApp.router(
            title: 'Eric Pereira',
            debugShowCheckedModeBanner: false,
            routerDelegate: Modular.routerDelegate,
            routeInformationParser: Modular.routeInformationParser,
            theme: CustomTheme.lightTheme,
            darkTheme: CustomTheme.darkTheme,
            themeMode: themeNotifier.currentTheme,
            locale: localizationNotifier.locale,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('pt', 'BR'), // Português
              Locale('en', 'US'), // Inglês
              Locale('es', 'ES'), // Espanhol
            ],
          );
        },
      ),
    );
  }
}
