import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:hunt_the_mafia/shared/global_context_service.dart';
import 'package:hunt_the_mafia/views/pages/pages.dart';

import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: MyTheme.lightTheme(lightColorScheme),
        darkTheme: MyTheme.darkTheme(darkColorScheme),
        navigatorKey: GlobalContextService.navigatorKey,
        initialRoute: DummyPage.routeName,
        routes: {
          DummyPage.routeName: (context) => const DummyPage(),
          MainMenuPage.routeName: (context) => const MainMenuPage(),
        },
      );
    });
  }
}
