import 'dart:async';

import 'package:bullet_train/game/game.dart';
import 'package:bullet_train/models/models.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

class TrainComponent extends PositionComponent
    with HasGameRef<BulletTrain>, CollisionCallbacks {
  TrainComponent({required this.trainBody})
      : super(
          priority: GameLayer.train.priority,
          anchor: Anchor.center,
        );

  final TrainBody trainBody;

  @override
  FutureOr<void> onLoad() {
    size = Vector2(
      gameRef.size.x / gameRef.world.gridSize.width,
      gameRef.size.y / gameRef.world.gridSize.height,
    );

    final paint = Paint()
      ..color = trainBody.isHead
          ? gameRef.theme.snakeHeadColor
          : gameRef.theme.snakeBodyColor;

    final trainSizeFactor = game.theme.trainSizeFactor;

    add(
      RectangleHitbox.relative(
        Vector2(trainSizeFactor, trainSizeFactor / 2),
        parentSize: size,
        isSolid: true,
      )
        ..paint = paint
        ..renderShape = true,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    _updatePosition();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is ScreenHitbox) {
      gameRef.over();
    } else if (other is TrainComponent) {
      gameRef.over();
    } else if (other is PassengerComponent) {
      gameRef.world.removePassenger(other.passenger);
      other.removeFromParent();

      switch (other.passenger.type) {
        case PassengerType.hero:
          gameRef.world.addTrainCar();
        case PassengerType.vilain:
          gameRef.world.removeTrainCar();
      }
    }
  }

  @override
  void onGameResize(Vector2 size) {
    _updatePosition();

    scale = Vector2(
      size.x / gameRef.world.gridSize.width / this.size.x,
      size.y / gameRef.world.gridSize.height / this.size.y,
    );

    super.onGameResize(size);
  }

  void _updatePosition() {
    final offset = trainBody.offset;

    if (offset != null) {
      position = trainBody.rail.cell
          .getOffsetFromScreenSize(offset, gameRef.size.toSize())
          .toVector2();

      final newAngle = trainBody.angle;
      if (newAngle != null) {
        angle = newAngle;
      }
    }
  }
}
