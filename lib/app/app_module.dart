import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';
import 'modules/portfolio/portfolio_module.dart';
import 'shared/widgets/page_notfound.dart';
import 'shared/i18n/localization_service.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => LocalizationService()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule()),
    ModuleRoute('/portfolio', module: PortfolioModule()),
    WildcardRoute(child: (context, args) => const NotFoundPage()),
  ];
}
