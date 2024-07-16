import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';
import 'shared/widgets/page_notfound.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule()),
    ModuleRoute('/sobre', module: HomeModule()),
    ModuleRoute('/portfolio', module: HomeModule()),
    ModuleRoute('/blog', module: HomeModule()),
    ModuleRoute('/contato', module: HomeModule()),
    WildcardRoute(child: (context, args) => NotFoundPage()),
  ];
}
