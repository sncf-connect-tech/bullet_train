import 'package:bullet_train/design/design.dart';
import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:bullet_train/menu/view/cache_loader.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay({
    required this.game,
    super.key,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CacheLoader(
      child: Material(
        color: theme.colorScheme.background.withOpacity(0.25),
        child: SafeArea(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.background.withOpacity(0.75),
                borderRadius: BorderRadius.circular(45),
              ),
              margin: const EdgeInsets.all(Dimens.rowSpacing),
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.rowSpacing,
                vertical: Dimens.columnSpacing,
              ),
              child: SingleChildScrollView(
                child: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.antiAlias,
                          fit: StackFit.passthrough,
                          children: [
                            NeonEffect(
                              child: Text(
                                'ゲームオーバー',
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                            NeonEffect(
                              child: Text(
                                'GAME OVER',
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Dimens.minColumnSpacing),
                      ElevatedButton(
                        onPressed: (game as BulletTrainGame).resetGame,
                        child: const Text('Rejouer'),
                      ),
                      const SizedBox(height: Dimens.minColumnSpacing),
                      ElevatedButton(
                        onPressed: Navigator.of(context).pop,
                        child: const Text("Retour à l'écran titre"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
