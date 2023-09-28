import 'package:bullet_train/design/theme/app_theme.dart';
import 'package:bullet_train/game/view/game_page.dart';
import 'package:bullet_train/menu/view/menu_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      routes: {
        '/': (context) => const MenuPage(),
        '/game': (context) => const GamePage(),
      },
    );
  }
}
