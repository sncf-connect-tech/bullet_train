import 'package:bullet_train/design/design.dart';
import 'package:bullet_train/menu/view/cache_loader.dart';
import 'package:bullet_train/menu/view/menu_image.dart';
import 'package:bullet_train/menu/view/menu_navigation.dart';
import 'package:bullet_train/menu/view/menu_title.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CacheLoader(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.rowSpacing),
            child: Center(
              child: Column(
                children: [
                  Expanded(child: MenuTitle()),
                  SizedBox(height: Dimens.columnSpacing),
                  MenuNavigation(),
                  SizedBox(height: Dimens.columnSpacing),
                  Expanded(flex: 3, child: MenuImage()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
