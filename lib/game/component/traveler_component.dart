import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class TravelerComponent extends CircleComponent
    with HasGameRef<BulletTrainGame> {
  TravelerComponent({
    required this.traveler,
  }) : super(
          priority: GameLayer.traveler.priority,
          anchor: Anchor.center,
        );

  final Traveler traveler;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    setSize();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position = traveler.offset.toVector2();
  }

  void setSize() {
    final theme = gameRef.theme;
    final trainSizeFactor = theme.trainSizeFactor;
    size = Vector2(trainSizeFactor, trainSizeFactor);
    add(CircleHitbox());

    switch (traveler.type) {
      case TravelerType.hero:
        paint.color = gameRef.theme.travelerHeroColor;
      case TravelerType.vilain:
        paint.color = gameRef.theme.travelerVillainColor;
    }
  }
}
