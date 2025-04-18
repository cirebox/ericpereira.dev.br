import 'package:flutter_modular/flutter_modular.dart';
import 'home_page.dart';
import '../../shared/services/news_service.dart';
import '../../shared/services/email_service.dart';
import '../../shared/i18n/localization_service.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    // Serviços
    Bind.lazySingleton<INewsService>((i) => NewsService()),
    Bind.lazySingleton<IEmailService>((i) => EmailService()),
    Bind.singleton((i) => LocalizationService()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      transition: TransitionType.noTransition,
      child: (_, args) => const HomePage(),
    ),
  ];
}
