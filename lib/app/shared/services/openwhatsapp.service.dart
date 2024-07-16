import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/snackbar/snackbar.dart';

void whatsAppOpen(BuildContext context) async {
  bool whatsapp = false;
  bool whatsappOpen = false;
  String phone = '5524992405601';
  String url =
      'https://api.whatsapp.com/send?phone=$phone&text=Ol%C3%A1!%20Gostaria%20de%20ajuda%20sobre%20';
  try {
    whatsapp = await FlutterLaunch.hasApp(name: "whatsapp");
  } catch (e) {
    debugPrint(e.toString());
    // ignore: use_build_context_synchronously
    whatsappOpen = await abrirUrl(url, context);
  }

  if (whatsapp && !whatsappOpen) {
    await FlutterLaunch.launchWhatsapp(
      phone: phone,
      message: "Olá! Gostaria de ajuda sobre ",
    );
  } else {
    try {
      // ignore: use_build_context_synchronously
      if (!whatsappOpen) {
        // ignore: use_build_context_synchronously
        whatsappOpen = await abrirUrl(url, context);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      snackBarWarning('Não foi possível abrir o chat', context: context);
      throw 'Não foi possível abrir o chat';
    }
  }
}

Future<bool> abrirUrl(String url, BuildContext context) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
    return true;
  } else {
    // ignore: use_build_context_synchronously
    snackBarWarning('Não foi possível acessar a página', context: context);
    throw 'Could not launch $url';
  }
}
