import 'package:flutter/material.dart';

class NavigationService {
  BuildContext? contextGlobal;

  NavigationService._();

  static final NavigationService _instance = NavigationService._();

  factory NavigationService() {
    return _instance;
  }

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
