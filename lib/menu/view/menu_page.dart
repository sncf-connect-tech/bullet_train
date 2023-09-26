import 'package:bullet_train/design/colors.dart';
import 'package:bullet_train/design/components/navigation_button.dart';
import 'package:bullet_train/design/components/neon_effect.dart';
import 'package:bullet_train/design/dimens.dart';
import 'package:bullet_train/game/game.dart';
import 'package:bullet_train/gen/assets.gen.dart';
import 'package:bullet_train/menu/components/menu_title.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const MenuPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: MenuView()),
    );
  }
}

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: rowSpacing),
      child: Center(
        child: Column(
          children: [
            const Expanded(child: MenuTitle()),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        // FIXME: ajouter un bouton pour lancer le jeu
                        Expanded(
                          child: NavigationButton(
                            onPressed: () {
                              Navigator.of(context).push(GamePage.route());
                            },
                            title: 'Démarrer',
                          ),
                        ),
                        const SizedBox(height: columnSpacing),
                        Expanded(
                          child: NavigationButton(
                            onPressed: () {/* TODO: ScorePage */},
                            title: 'Score',
                          ),
                        ),
                        const SizedBox(height: columnSpacing),
                        Expanded(
                          child: NavigationButton(
                            onPressed: () {/* TODO: AboutPage */},
                            title: 'À propos',
                          ),
                        ),
                        const SizedBox(height: columnSpacing),
                      ],
                    ),
                  ),
                  const SizedBox(width: rowSpacing),
                  NeonEffect(
                    color: ConnectColors.error,
                    child: Assets.images.bulletTrainCharacters.image(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
