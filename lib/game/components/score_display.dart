import 'package:bullet_train/game/bullet_train.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class ScoreDisplay extends StatelessWidget {
  const ScoreDisplay({required this.game, super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: (game as BulletTrain).score,
      builder: (context, score, _) {
        return Text(
          'SCORE : $score',
          style: Theme.of(context).textTheme.displayLarge,
        );
      },
    );
  }
}
