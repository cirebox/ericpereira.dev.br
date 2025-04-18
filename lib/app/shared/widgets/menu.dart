import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../i18n/app_translations.dart';
import 'button_theme.dart';
import 'header/contact_button.dart';
import 'header/language_button.dart';
import 'text_custom.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // Lista de itens do menu de navegação
  final List<Map<String, String>> _navigationItems = [
    //{'text': 'portfolio', 'route': '/portfolio/'},
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          // Layout de desktop - menu horizontal
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Links de navegação
              ...buildNavigationItems(context),

              const SizedBox(width: 10), // Espaçamento entre navegação e ações

              // Linha divisória
              Container(
                height: 25,
                width: 1,
                color: Theme.of(context).dividerColor.withOpacity(0.3),
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),

              // Botões de ação (idioma, tema, contato)
              const ButtonThemeWidget(),
              const LanguageButton(),
              const ContactButton(),
            ],
          );
        } else {
          // Layout mobile - menu em drawer
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botão para fechar o drawer
              Row(
                children: [
                  Expanded(child: Container()),
                  IconButton(
                    onPressed: () => Modular.to.pop(),
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).textTheme.titleMedium!.color,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              // Links de navegação em coluna
              ...buildNavigationItems(context, isVertical: true),

              const SizedBox(height: 30),

              // Divisor
              Divider(color: Theme.of(context).dividerColor.withOpacity(0.3)),

              const SizedBox(height: 20),

              // Ações organizadas em linha
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  LanguageButton(),
                  ButtonThemeWidget(),
                ],
              ),

              const SizedBox(height: 30),

              // Botão de contato em destaque
              const Center(child: ContactButton()),
            ],
          );
        }
      },
    );
  }

  // Constrói os itens de navegação
  List<Widget> buildNavigationItems(BuildContext context,
      {bool isVertical = false}) {
    return _navigationItems.map((item) {
      final bool isCurrentRoute = Modular.to.path == item['route'];

      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isVertical ? 0 : 10,
          vertical: isVertical ? 8 : 0,
        ),
        child: InkWell(
          onTap: () {
            Modular.to.navigate(item['route']!);
            if (isVertical) {
              Modular.to.pop(); // Fecha o drawer em mobile
            }
          },
          borderRadius: BorderRadius.circular(4),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: isVertical ? 8 : 5,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isCurrentRoute
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: TextCustom(
              Translate.text(item['text']!, context),
              fontSize: 15,
              fontWeight: isCurrentRoute ? FontWeight.w600 : FontWeight.w400,
              color: isCurrentRoute
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ),
      );
    }).toList();
  }
}
