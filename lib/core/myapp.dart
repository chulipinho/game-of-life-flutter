import 'package:flutter/material.dart';
import 'package:game_of_life/core/app_themes.dart';
import 'package:game_of_life/main_screen/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game of Life',
      theme: AppThemes.lightTheme,
      home: const MainScreen(),
    );
  }
}
