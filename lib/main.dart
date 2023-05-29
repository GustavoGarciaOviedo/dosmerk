import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:dosmerk/config/app_theme.dart';
import 'package:dosmerk/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async{
  await dotenv.load(fileName: ".env");//importacion y carpinteria para agregar el .env
  runApp(const ProviderScope(child:  MainApp()));//providerScope es necesario si implemento riverpod
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
