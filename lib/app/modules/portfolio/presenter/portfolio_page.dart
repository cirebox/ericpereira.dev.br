import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../../core/domain/exceptions/exceptions.dart';
import '../../../shared/widgets/layout_page.dart';
import '../../../shared/widgets/text_custom.dart';
import '../domain/entities/project.entity.dart';
import 'portfolio_store.dart';
import 'widgets/project_card.dart';

class PortfolioPage extends StatefulWidget {
  final String title;
  const PortfolioPage({Key? key, this.title = 'Portfolio'}) : super(key: key);

  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  var store = Modular.get<PortfolioStore>();

  @override
  void initState() {
    store.getProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutPage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: TextCustom(
              'Portfólio',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              height: 0.2,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ScopedBuilder<PortfolioStore, Failure, List<ProjectEntity>>(
              store: store,
              onLoading: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
              onState: (context, state) {
                return Wrap(
                  spacing: 15,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.spaceBetween,
                  children: state
                      .map(
                        (project) => ProjectCard(
                          name: project.name,
                          imageUrl: project.imageUrl,
                          launch: project.launch,
                          urlDemo: project.urlDemo,
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
