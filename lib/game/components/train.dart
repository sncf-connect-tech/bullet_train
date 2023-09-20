import 'dart:async';
import 'dart:ui';

import 'package:bullet_train/game/bullet_train.dart';
import 'package:bullet_train/models/models.dart';
import 'package:bullet_train/models/train/train.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class TrainComponent extends PositionComponent with HasGameRef<BulletTrain> {
  TrainComponent({required this.trainBody})
      : super(priority: GameLayer.train.priority);

  final TrainBody trainBody;

  @override
  FutureOr<void> onLoad() {
    final paint = Paint()
      ..color =
          trainBody.isHead ? gameRef.theme.snakeHead : gameRef.theme.snakeBody;

    add(
      CircleComponent(
        paint: paint,
        radius: _trainSize,
        anchor: Anchor.center,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    final offset = trainBody.offset;

    if (offset == null) return;

    position = offset.toVector2();
  }

  @override
  void onGameResize(Vector2 size) {
    final offset = trainBody.offset;

    if (offset != null) {
      position = offset.toVector2();
    }

    children.whereType<CircleComponent>().single.radius = _trainSize;

    super.onGameResize(size);
  }

  double get _trainSize => game.size.x / game.theme.gridSize / 2 * 0.7;
}
