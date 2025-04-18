import 'package:flutter_modular/flutter_modular.dart';
import 'data/repositories/projects.repository.dart';
import 'domain/repositories/projetcs.repository.interface.dart';
import 'domain/usescases/getprojects.dart';
import 'presenter/portfolio_page.dart';
import 'presenter/portfolio_store.dart';

class PortfolioModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<IProjectsRepository>((i) => ProjectsRepository()),
    Bind.lazySingleton<GetProjects>((i) => GetProjects(i())),
    Bind.lazySingleton<PortfolioStore>((i) => PortfolioStore(i())),
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
