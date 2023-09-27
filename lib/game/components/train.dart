import 'dart:async';

import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/game.dart';
import 'package:bullet_train/theme/theme.dart';
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

  Size get _gridSize => gameRef.engineWorld.gridSize;
  Vector2 get _parentSize => gameRef.size;
  GameTheme get _theme => gameRef.theme;

  @override
  FutureOr<void> onLoad() {
    size = Vector2(
      _parentSize.x / _gridSize.width,
      _parentSize.y / _gridSize.height,
    );

    final paint = Paint()
      ..color =
          trainBody.isHead ? _theme.snakeHeadColor : _theme.snakeBodyColor;

    final trainSizeFactor = _theme.trainSizeFactor;

    add(
      RectangleHitbox.relative(
        Vector2(trainSizeFactor, trainSizeFactor / 2),
        parentSize: size,
        isSolid: true,
        collisionType:
            trainBody.isHead ? CollisionType.active : CollisionType.passive,
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
    } else if (other is TravellerComponent) {
      gameRef.engineWorld.removeTraveller(other.traveller);
      other.removeFromParent();

      switch (other.traveller.type) {
        case TravellerType.hero:
          gameRef.engineWorld.onScoreIncrease();
          gameRef.engineWorld.addTrainCar();
        case TravellerType.vilain:
          gameRef.engineWorld.onScoreDecrease();
          gameRef.engineWorld.removeTrainCar();
      }
    }
  }

  @override
  void onParentResize(Vector2 maxSize) {
    _updatePosition();

    scale = Vector2(
      (maxSize.x / _gridSize.width) / size.x,
      (maxSize.y / _gridSize.height) / size.y,
    );

    super.onParentResize(maxSize);
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
