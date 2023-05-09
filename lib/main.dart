import 'package:flutter/material.dart';

import 'package:dosmerk/config/app_theme.dart';
import 'package:dosmerk/router/app_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: Apptheme().getTheme(),
     
    );
  }
}
