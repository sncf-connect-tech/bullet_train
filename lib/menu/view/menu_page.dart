import 'package:bullet_train/design/design.dart';
import 'package:bullet_train/menu/components/difficulty_selector.dart';
import 'package:bullet_train/menu/components/menu_title.dart';
import 'package:bullet_train/shared/cache_loader.dart';
import 'package:bullet_train/shared/difficulty.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return CacheLoader(
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
                                    Navigator.of(context).pushNamed('/game');
                                  },
                                ),
                              ),
                              const SizedBox(height: Dimens.columnSpacing),
                              Expanded(
                                child: NavigationButton(
                                  title: 'Score',
                                  onPressed: () {
                                    /* TODO: ScorePage */
                                  },
                                ),
                              ),
                              const SizedBox(height: Dimens.columnSpacing),
                              Expanded(
                                child: NavigationButton(
                                  title: 'À propos',
                                  onPressed: () {
                                    /* TODO: AboutPage */
                                  },
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
                            child: Image.asset(
                              'assets/images/bullet_train_characters.png',
                            ),
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
