import 'package:flutter_modular/flutter_modular.dart';
import 'data/repositories/projects.repository.dart';
import 'domain/usescases/getprojects.dart';
import 'presenter/portfolio_page.dart';
import 'presenter/portfolio_store.dart';

class PortfolioModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProjectsRepository()),
    Bind.lazySingleton((i) => GetProjects(i.get<ProjectsRepository>())),
    Bind.lazySingleton((i) => PortfolioStore(i.get<GetProjects>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      transition: TransitionType.noTransition,
      child: (_, args) => const PortfolioPage(),
    ),
  ];
}
