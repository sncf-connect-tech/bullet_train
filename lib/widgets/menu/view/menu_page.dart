import 'package:bullet_train/design/design.dart';
import 'package:bullet_train/game/game.dart';
import 'package:bullet_train/gen/assets.gen.dart';
import 'package:bullet_train/shared/difficulty.dart';
import 'package:bullet_train/widgets/menu/components/difficulty_selector.dart';
import 'package:bullet_train/widgets/menu/components/menu_title.dart';
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

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  Difficulty difficulty = Difficulty.easy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.rowSpacing),
      child: Stack(
        children: [
          Positioned(
            top: 30,
            right: 30,
            child: DifficultySelector(
              initialDifficulty: difficulty,
              onSelected: (selectedDifficulty) {
                if (selectedDifficulty != null) {
                  setState(() {
                    difficulty = selectedDifficulty;
                  });
                }
              },
            ),
          ),
          Center(
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
                                  Navigator.of(context).push(
                                    GamePage.route(difficulty: difficulty),
                                  );
                                },
                                title: 'Démarrer',
                              ),
                            ),
                            const SizedBox(height: Dimens.columnSpacing),
                            Expanded(
                              child: NavigationButton(
                                onPressed: () {/* TODO: ScorePage */},
                                title: 'Score',
                              ),
                            ),
                            const SizedBox(height: Dimens.columnSpacing),
                            Expanded(
                              child: NavigationButton(
                                onPressed: () {/* TODO: AboutPage */},
                                title: 'À propos',
                              ),
                            ),
                            const SizedBox(height: Dimens.columnSpacing),
                          ],
                        ),
                      ),
                      const SizedBox(width: Dimens.rowSpacing),
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
        ],
      ),
    );
  }
}
