import 'dart:async';
import 'dart:collection';

import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/component/background_component.dart';
import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:bullet_train/game/component/traveler_component.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

final class WagonComponent extends SpriteAnimationComponent
    with
        HasGameRef<BulletTrainGame>,
        CollisionCallbacks,
        LinkedListEntry<WagonComponent> {
  WagonComponent({required this.wagon})
      : super(
          priority: GameLayer.train.priority,
          anchor: Anchor.center,
        );

  final Wagon wagon;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await _loadSpriteAnimation();
    _setSize();
  }

  @override
  void update(double dt) {
    super.update(dt);
    final offset = wagon.offset;
    if (offset != null) {
      angle = wagon.angle ?? angle;
      position = offset.toVector2();
    }
  }

  void _setSize() {
    final theme = gameRef.theme;
    final trainSizeFactor = theme.trainSizeFactor;
    size = Vector2(trainSizeFactor, trainSizeFactor / 2);
    add(
      RectangleHitbox(
        collisionType: switch (wagon) {
          HeadWagon() => CollisionType.active,
          BodyWagon() => CollisionType.passive
        },
      ),
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    switch (other) {
      case BackgroundComponent():
      case WagonComponent():
        if (previous != other && next != other) {
          gameRef.gameOver();
        }
      case TravelerComponent():
        gameRef.travelersComponent.removeTraveler(other.traveler);
        other.removeFromParent();
        switch (other.traveler.type) {
          case TravelerType.hero:
            gameRef.trainComponent.addWagon();
          case TravelerType.vilain:
            gameRef.trainComponent.removeWagon();
        }
    }
    gameRef.travelersComponent.addTravelersIfPossible();
  }

  Future<void> _loadSpriteAnimation() async {
    final String filename;

    switch (wagon) {
      case HeadWagon():
        filename = 'head.png';
      case BodyWagon():
        filename = 'car.png';
    }

    animation = await gameRef.loadSpriteAnimation(
      filename,
      SpriteAnimationData.sequenced(
        amount: 8,
        amountPerRow: 4,
        stepTime: 0.5,
        textureSize: Vector2(64, 32),
      ),
    );
  }
}
