import 'package:ericpereira/app/shared/widgets/text_custom.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    return SizedBox(
      height: 30,
      child: TextCustom(
        '© $currentYear • Eric Pereira',
        fontSize: 18,
      ),
    );
  }
}
