import 'package:flutter/material.dart';

import '../../services/navigation.service.dart';

const int _secondsDuration = 6;

enum SnackbarType {
  success,
  danger,
  warning,
  info,
}

void snackBarSuccess(String text, {BuildContext? context}) {
  try {
    ScaffoldMessenger.of(
            context ?? NavigationService.navigatorKey.currentContext!)
        .showSnackBar(
      snackBar(text, SnackbarType.success),
    );
  } catch (e) {
    debugPrint(e.toString());
  }
}

void snackBarWarning(String text, {BuildContext? context}) {
  try {
    ScaffoldMessenger.of(
            context ?? NavigationService.navigatorKey.currentContext!)
        .showSnackBar(
      snackBar(text, SnackbarType.warning),
    );
  } catch (e) {
    debugPrint(e.toString());
  }
}

void snackBarDanger(String text) {
  try {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
        .showSnackBar(
      snackBar(text, SnackbarType.danger),
    );
  } catch (e) {
    debugPrint(e.toString());
  }
}

void snackBarInfo(String text) {
  try {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
        .showSnackBar(
      snackBar(text, SnackbarType.danger),
    );
  } catch (e) {
    debugPrint(e.toString());
  }
}

SnackBar snackBar(String text, SnackbarType type) => SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: _secondsDuration),
      backgroundColor: getColor(type),
      content: Text(
        text,
        softWrap: true,
        textScaleFactor: 0.8,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );

Color getColor(SnackbarType type) {
  switch (type) {
    case SnackbarType.success:
      return Colors.green.withOpacity(0.9);
    case SnackbarType.danger:
      return Colors.yellow.withOpacity(0.9);
    case SnackbarType.warning:
      return Colors.red.withOpacity(0.9);
    case SnackbarType.info:
      return Colors.blue.withOpacity(0.9);
    default:
      return Colors.black.withOpacity(0.9);
  }
}
