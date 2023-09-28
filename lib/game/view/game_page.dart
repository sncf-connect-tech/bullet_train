import 'package:bullet_train/design/theme/game_theme.dart';
import 'package:bullet_train/game/bullet_train.dart';
import 'package:bullet_train/game/components/game_over.dart';
import 'package:bullet_train/game/components/score_display.dart';
import 'package:bullet_train/shared/difficulty.dart';
import 'package:flame/game.dart' hide Route;
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({this.difficulty = Difficulty.medium, super.key});

  final Difficulty difficulty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GameView(difficulty: difficulty),
      ),
    );
  }
}

class GameView extends StatefulWidget {
  const GameView({required this.difficulty, this.game, super.key});

  final FlameGame? game;
  final Difficulty difficulty;

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  FlameGame? _game;
  bool _gameOver = false;

  @override
  Widget build(BuildContext context) {
    final gameTheme =
        Theme.of(context).extension<GameTheme>() ?? GameTheme.defaultGameTheme;

    _game ??= widget.game ??
        BulletTrain(
          theme: gameTheme,
          difficulty: widget.difficulty,
          onGameOver: () {
            setState(() {
              _gameOver = true;
            });
          },
        );
    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: AspectRatio(
              aspectRatio: gameTheme.gridAspectRatio,
              child: GameWidget(game: _game!),
            ),
          ),
        ),
        Positioned(
          top: 30,
          left: 30,
          child: ScoreDisplay(game: _game!),
        ),
        Center(
          child: GameOver(
            isVisible: _gameOver,
            onPressContinue: () {
              setState(() {
                _gameOver = false;
              });

              _game = BulletTrain(
                theme: gameTheme,
                difficulty: widget.difficulty,
                onGameOver: () {
                  setState(() {
                    _gameOver = true;
                  });
                },
              );
            },
            onPressLeave: () {
              setState(() {
                _gameOver = false;
              });
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
