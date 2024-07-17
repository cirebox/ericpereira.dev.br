import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/theme/theme.custom.app.dart';

void main() {
  // ignore: prefer_const_constructors
  // setUrlStrategy(PathUrlStrategy());

  runApp(
    ChangeNotifierProvider(
      create: (context) => CustomTheme(),
      child: ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    ),
  );
}
