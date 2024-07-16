import 'package:ericpereira/app/shared/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'footer.dart';
import 'header.dart';
import 'menu.dart';

class NotFoundPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _sKey = GlobalKey();

  NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _sKey,
        persistentFooterAlignment: AlignmentDirectional.bottomCenter,
        persistentFooterButtons: const [
          Footer(),
        ],
        endDrawerEnableOpenDragGesture: true,
        endDrawer: const Drawer(child: Menu()),
        appBar: header(_sKey),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 150, maxWidth: 800),
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const TextCustom(
                    '404',
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  // Container(
                  //   height: 60,
                  //   width: 2,
                  //   color: Theme.of(context).textTheme.titleMedium!.color,
                  // ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 400,
                        child: TextCustom(
                          'Desculpe, não conseguimos encontrar esta página.',
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                          color: Theme.of(context).textTheme.titleMedium!.color,
                          fontWeight: FontWeight.w600,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 500,
                        child: TextCustom(
                          'Mas não se preocupe, você pode encontrar muitas outras coisas em nossa página inicial.',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.titleMedium!.color,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () => Modular.to.pushNamed('/'),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: TextCustom(
                              'Voltar á pagina inicial',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
