import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class ScoreOverlay extends StatelessWidget {
  const ScoreOverlay({required this.game, super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background.withOpacity(0.5),
              borderRadius: BorderRadius.circular(45),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ValueListenableBuilder(
                valueListenable: (game as BulletTrainGame).scoreManager.score,
                builder: (context, score, child) {
                  return Text(
                    'SCORE : $score',
                    style: Theme.of(context).textTheme.displayLarge,
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background.withOpacity(0.5),
              borderRadius: BorderRadius.circular(45),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ValueListenableBuilder(
                valueListenable:
                    (game as BulletTrainGame).scoreManager.bestScore,
                builder: (context, bestScore, child) {
                  return Text(
                    'BEST : $bestScore',
                    style: Theme.of(context).textTheme.displayLarge,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
