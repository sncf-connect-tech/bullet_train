import 'dart:async';
import 'dart:collection';

import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

final class WagonComponent extends RectangleComponent
    with HasGameRef<BulletTrainGame>, LinkedListEntry<WagonComponent> {
  WagonComponent({required this.wagon})
      : super(
          priority: GameLayer.train.priority,
          anchor: Anchor.center,
        );

  final Wagon wagon;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _setSize();
  }

  @override
  void update(double dt) {
    super.update(dt);

    position = wagon.offset?.toVector2() ?? position;
    angle = wagon.angle ?? angle;
  }

  void _setSize() {
    final theme = gameRef.theme;
    final trainSizeFactor = theme.trainSizeFactor;
    size = Vector2(trainSizeFactor, trainSizeFactor / 2);
  }
}
