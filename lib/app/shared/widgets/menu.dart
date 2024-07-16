import 'package:ericpereira/app/shared/widgets/text_custom.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildMenuButton(text: 'Blog', route: ''),
        _buildMenuButton(text: 'Sobre', route: ''),
        _buildMenuButton(text: 'Portfólio', route: ''),
        _buildMenuButton(text: 'Contato', route: ''),
      ],
    );
  }

  Widget _buildMenuButton({required text, required route}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(route),
        hoverColor: Colors.transparent,
        child: TextCustom(
          text,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.titleMedium!.color,
        ),
      ),
    );
  }
}
