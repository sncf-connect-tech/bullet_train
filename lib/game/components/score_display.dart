import 'package:bullet_train/design/colors.dart';
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
          style: const TextStyle(
            color: ConnectColors.primaryDark,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        );
      },
    );
  }
}
