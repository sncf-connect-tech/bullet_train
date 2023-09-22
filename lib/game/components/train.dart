import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:bullet_train/game/bullet_train.dart';
import 'package:bullet_train/models/models.dart';
import 'package:bullet_train/models/train/train.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class TrainComponent extends PositionComponent
    with HasGameRef<BulletTrain>, CollisionCallbacks {
  TrainComponent({required this.trainBody})
      : super(priority: GameLayer.train.priority);

  final TrainBody trainBody;

  @override
  FutureOr<void> onLoad() {
    final paint = Paint()
      ..color =
          trainBody.isHead ? gameRef.theme.snakeHead : gameRef.theme.snakeBody;

    add(
      CircleHitbox(
        radius: _trainSize,
        anchor: Anchor.center,
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
    }
  }

  @override
  void onGameResize(Vector2 size) {
    _updatePosition();

    children.whereType<CircleHitbox>().single.radius = _trainSize;

    super.onGameResize(size);
  }

  void _updatePosition() {
    final offset = trainBody.offset;

    if (offset != null) {
      position = offset
          .scale(
            game.size.x / gameRef.world.gridSize.width,
            game.size.y / gameRef.world.gridSize.height,
          )
          .toVector2();
    }
  }

  double get _trainSize {
    final trainSizeFactor = game.theme.trainSizeFactor;
    return math.min(
      game.size.x / game.theme.gridSize.width / 2 * trainSizeFactor,
      game.size.y / game.theme.gridSize.height / 2 * trainSizeFactor,
    );
  }
}
