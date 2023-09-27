import 'dart:async';

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
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const MenuPage(),
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
  Difficulty difficulty = Difficulty.medium;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      child: Padding(
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
                    setState(() => difficulty = selectedDifficulty);
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
                                  title: 'Démarrer',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      GamePage.route(difficulty: difficulty),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: Dimens.columnSpacing),
                              Expanded(
                                child: NavigationButton(
                                  title: 'Score',
                                  onPressed: () {/* TODO: ScorePage */},
                                ),
                              ),
                              const SizedBox(height: Dimens.columnSpacing),
                              Expanded(
                                child: NavigationButton(
                                  title: 'À propos',
                                  onPressed: () {/* TODO: AboutPage */},
                                ),
                              ),
                              const SizedBox(height: Dimens.columnSpacing),
                            ],
                          ),
                        ),
                        const SizedBox(width: Dimens.rowSpacing),
                        Expanded(
                          flex: 2,
                          child: NeonEffect(
                            child: Assets.images.bulletTrainCharacters.image(),
                          ),
                        ),
                      ],
                    ),
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
