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
    _setSize();
    await _loadSpriteAnimation();
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
        other.removeFromParent();

        switch (other.type) {
          case TravelerType.hero:
            gameRef.trainComponent.addWagon();
          case TravelerType.vilain:
            gameRef.trainComponent.removeWagon();
        }

        gameRef.travelersComponent.addTravelersIfPossible();
    }
  }

  Future<void> _loadSpriteAnimation() async {
    // TODO: charger les différents sprites de wagons
  }
}
