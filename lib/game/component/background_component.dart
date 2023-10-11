import 'dart:async';

import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class BackgroundComponent extends PositionComponent
    with HasGameRef<BulletTrainGame>, BackgroundParity {
  BackgroundComponent() : super(priority: GameLayer.background.priority);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = gameRef.theme.gridSize.toVector2();

    final hitbox = RectangleHitbox(collisionType: CollisionType.passive);
    makeCollidableVisible(hitbox);
    add(hitbox);

    for (final cell in gameRef.matrix.cells) {
      add(
        RectangleComponent.fromRect(
          cell.rect,
          paint: getPaintFromCellParity(cell.parity),
        ),
      );
    }
  }
}
