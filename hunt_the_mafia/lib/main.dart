import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:hunt_the_mafia/shared/global_context_service.dart';
import 'package:hunt_the_mafia/views/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        title: 'Hunt The Mafia',
        debugShowCheckedModeBanner: false,
        theme: MyTheme.lightTheme(lightColorScheme),
        darkTheme: MyTheme.darkTheme(darkColorScheme),
        navigatorKey: GlobalContextService.navigatorKey,
        initialRoute: DummyPage.routeName,
        routes: {
          DummyPage.routeName: (context) => const DummyPage(),
          MainMenuPage.routeName: (context) => const MainMenuPage(),
          ShopPage.routeName: (context) => const ShopPage(),
          PreparationPage.routeName: (context) => const PreparationPage(),
          GameRoomPage.routeName: (context) => const GameRoomPage(),
          // GamePage.routeName: (context) => const GamePage(),
          SettingPage.routeName: (context) => const SettingPage(),
        },
      );
    });
  }
}
