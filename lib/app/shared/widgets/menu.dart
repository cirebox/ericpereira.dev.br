import 'package:ericpereira/app/shared/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildMenuButton(text: 'Sobre', route: '/sobre/'),
              _buildMenuButton(text: 'Portfólio', route: '/portfolio/'),
              _buildMenuButton(text: 'Blog', route: '/blog/'),
              _buildMenuButton(text: 'Contato', route: '/contato/'),
            ],
          );
        }

        return ListView(
          padding: const EdgeInsets.all(15),
          children: [
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
            _buildMenuButton(text: 'Sobre', route: '/sobre/'),
            _buildMenuButton(text: 'Portfólio', route: '/portfolio/'),
            _buildMenuButton(text: 'Blog', route: '/blog/'),
            _buildMenuButton(text: 'Contato', route: '/contato/'),
          ],
        );
      },
    );
  }

  Widget _buildMenuButton({required text, required route}) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: InkWell(
          onTap: () => Modular.to.pushNamed(route),
          hoverColor: Colors.transparent,
          child: TextCustom(
            text,
            fontSize:
                sizingInformation.deviceScreenType == DeviceScreenType.desktop
                    ? 18
                    : 24,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
        ),
      );
    });
  }
}
