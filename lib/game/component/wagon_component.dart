import 'dart:collection';

import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:flame/components.dart';

final class WagonComponent extends RectangleComponent
    with HasGameRef<BulletTrainGame>, LinkedListEntry<WagonComponent> {
  WagonComponent({required this.wagon})
      : super(
          priority: GameLayer.train.priority,
          anchor: Anchor.center,
        );

  final Wagon wagon;
}
