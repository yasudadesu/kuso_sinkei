import 'package:flutter/material.dart';
import 'package:muzui_sinkei/game.dart';

import 'mode_select.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '間違い探し神経衰弱',
      debugShowCheckedModeBanner: false,
      theme: defaultThemeData,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => ModeSelectScreen(),
        '/game': (BuildContext context) => GameScreen(),
      },
    );
  }
}

ThemeData defaultThemeData = ThemeData.light().copyWith(
    primaryColor: const Color(0xFFff6e40),
    accentColor: const Color(0xFF1976d2),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF4484B0),
      elevation: 0,
    ),
    appBarTheme: const AppBarTheme(elevation: 0),
    tabBarTheme: const TabBarTheme(),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ));
