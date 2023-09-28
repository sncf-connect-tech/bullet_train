import 'package:bullet_train/menu/title.dart';
import 'package:bullet_train/theme/app_theme.dart';
import 'package:flutter/material.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home: const MenuPage(),
    );
  }
}
