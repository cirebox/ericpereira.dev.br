import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LocalizationService extends ChangeNotifier {
  static final LocalizationService _instance = LocalizationService._internal();

  factory LocalizationService() {
    return _instance;
  }

  LocalizationService._internal();

  Locale _locale = const Locale('pt', 'BR');

  Locale get locale => _locale;

  void changeLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  // Método para alternar entre os idiomas disponíveis
  void toggleLanguage() {
    if (_locale.languageCode == 'pt') {
      changeLocale(const Locale('en', 'US'));
    } else if (_locale.languageCode == 'en') {
      changeLocale(const Locale('es', 'ES'));
    } else {
      changeLocale(const Locale('pt', 'BR'));
    }
  }

  // Obter texto para o botão de alternância de idioma
  String getLanguageButtonText() {
    switch (_locale.languageCode) {
      case 'pt':
        return 'PT';
      case 'en':
        return 'EN';
      case 'es':
        return 'ES';
      default:
        return 'PT';
    }
  }
}

// Extensão do LocalizationService para ser usado como bind no Modular
final $LocalizationService = BindInject(
  (i) => LocalizationService(),
  isSingleton: true,
  isLazy: false,
);
