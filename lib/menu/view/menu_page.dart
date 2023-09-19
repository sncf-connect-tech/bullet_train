import 'package:bullet_train/game/game.dart';
import 'package:bullet_train/l10n/l10n.dart';
import 'package:bullet_train/menu/components/navigation_button.dart';
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
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.menuAppBarTitle),
      ),
      body: const SafeArea(child: MenuView()),
    );
  }
}

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: SizedBox(
        width: 250,
        height: 200,
        child: Column(
          children: [
            // FIXME: ajouter un bouton pour lancer le jeu
            NavigationButton(
              onPressed: () => Navigator.of(context).push(GamePage.route()),
              title: l10n.menuButtonStart,
            ),
            const SizedBox(height: 30),
            NavigationButton(
              onPressed: () {/* TODO: ScorePage */},
              title: l10n.menuButtonScore,
            ),
            const SizedBox(height: 30),
            NavigationButton(
              onPressed: () {/* TODO: AboutPage */},
              title: l10n.menuButtonAbout,
            ),
          ],
        ),
      ),
    );
  }
}
