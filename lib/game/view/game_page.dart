import 'package:bullet_train/design/theme/game_theme.dart';
import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:bullet_train/game/view/game_over_overlay.dart';
import 'package:flame/game.dart' hide Route;
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final gameTheme =
        Theme.of(context).extension<GameTheme>() ?? GameTheme.defaultGameTheme;
    final game = BulletTrainGame(theme: gameTheme);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ClipRect(
            child: AspectRatio(
              aspectRatio: gameTheme.gridAspectRatio,
              child: GameWidget(
                game: game,
                overlayBuilderMap: {
                  'gameOverOverlay': (BuildContext context, Game game) =>
                      GameOverOverlay(game: game),
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
