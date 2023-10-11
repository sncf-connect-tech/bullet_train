import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class TravelerComponent extends SpriteComponent
    with HasGameRef<BulletTrainGame> {
  TravelerComponent({
    required this.type,
    required this.cell,
  }) : super(
          priority: GameLayer.traveler.priority,
          anchor: Anchor.center,
        );

  final TravelerType type;
  final Cell cell;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await _loadSprite();
    setSize();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position = cell.rect.center.toVector2();
  }

  void setSize() {
    final theme = gameRef.theme;
    final trainSizeFactor = theme.trainSizeFactor;
    size = Vector2(trainSizeFactor, trainSizeFactor);
    add(CircleHitbox());
  }

  Future<void> _loadSprite() async {
    // TODO: charger le sprite de hero
    // TODO: charger le(s) sprite(s) de villain(s)
  }
}
