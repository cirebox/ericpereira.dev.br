import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';
import 'modules/portfolio/portfolio_module.dart';
import 'modules/sobre/about_module.dart';
import 'shared/widgets/page_notfound.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule()),
    ModuleRoute('/sobre', module: AboutModule()),
    ModuleRoute('/portfolio', module: PortfolioModule()),
    ModuleRoute('/blog', module: HomeModule()),
    WildcardRoute(child: (context, args) => const NotFoundPage()),
  ];
}
