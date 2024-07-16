import 'package:ericpereira/app/shared/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: InkWell(
        onTap: () => Modular.to.pushNamed('/'),
        hoverColor: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: TextCustom(
                  'E',
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            TextCustom(
              'Eric',
              fontWeight: FontWeight.w700,
              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
              color: Theme.of(context).textTheme.titleMedium!.color,
            ),
            const SizedBox(
              width: 5,
            ),
            TextCustom(
              'Pereira',
              fontWeight: FontWeight.w700,
              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
              color: Theme.of(context).textTheme.titleMedium!.color,
            ),
          ],
        ),
      ),
    );
  }
}
