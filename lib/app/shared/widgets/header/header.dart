import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../button_theme.dart';
import '../logo.dart';
import '../menu.dart';
import 'language_button.dart';
import 'contact_button.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HeaderWidget({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          scaffoldKey.currentState?.closeEndDrawer();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Logo(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Menu de navegação (apenas no desktop)
                    if (sizingInformation.deviceScreenType ==
                        DeviceScreenType.desktop)
                      const Menu(),

                    // Botão de menu hamburguer (apenas em dispositivos móveis)
                    if (sizingInformation.deviceScreenType !=
                        DeviceScreenType.desktop)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: IconButton(
                          onPressed: () =>
                              scaffoldKey.currentState?.openEndDrawer(),
                          icon: Icon(
                            Icons.menu,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Função auxiliar para manter compatibilidade com código existente
PreferredSizeWidget header(GlobalKey<ScaffoldState> key) {
  return HeaderWidget(scaffoldKey: key);
}
