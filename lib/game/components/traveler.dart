import 'dart:math' as math;

import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/bullet_train.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/painting.dart';

class TravelerComponent extends CircleComponent with HasGameRef<BulletTrain> {
  TravelerComponent({
    required this.traveler,
  }) : super(priority: GameLayer.traveler.priority);

  final Traveler traveler;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final paint = Paint()
      ..color = switch (traveler.type) {
        TravelerType.hero => gameRef.theme.travelerHeroColor,
        TravelerType.vilain => gameRef.theme.travelerVillainColor
      };

    add(
      CircleHitbox(
        radius: _travelerRadius,
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
  void onGameResize(Vector2 size) {
    _updatePosition();

    children.whereType<CircleHitbox>().single.radius = _travelerRadius;

    super.onGameResize(size);
  }

  void _updatePosition() {
    final offset = traveler.offset;

    position = traveler.cell
        .getOffsetFromScreenSize(offset, gameRef.size.toSize())
        .toVector2();
  }

  double get _travelerRadius {
    final travelerSizeFactor = game.theme.travelerSizeFactor;

    return math.min(
      game.size.x / game.theme.gridSize.width / 2 * travelerSizeFactor,
      game.size.y / game.theme.gridSize.height / 2 * travelerSizeFactor,
    );
  }
}
