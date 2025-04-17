import 'package:flutter_modular/flutter_modular.dart';

import 'modules/portfolio/portfolio_module.dart';
import 'modules/about/about_module.dart';
import 'shared/widgets/page_notfound.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: AboutModule()),
    ModuleRoute('/sobre', module: AboutModule()),
    ModuleRoute('/portfolio', module: PortfolioModule()),
    WildcardRoute(child: (context, args) => const NotFoundPage()),
  ];
}
