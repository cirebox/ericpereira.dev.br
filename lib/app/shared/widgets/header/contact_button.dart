import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/openwhatsapp.service.dart';
import '../../i18n/app_translations.dart';

class ContactButton extends StatelessWidget {
  const ContactButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton.icon(
        onPressed: () => whatsAppOpen(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade600,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        icon: const FaIcon(
          FontAwesomeIcons.whatsapp,
          size: 20,
        ),
        label: Text(
          Translate.text('contactMe', context),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
