import 'dart:math' as math;

import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/painting.dart';

class TravellerComponent extends CircleComponent with HasGameRef<BulletTrain> {
  TravellerComponent({
    required this.traveller,
  }) : super(priority: GameLayer.traveller.priority);

  final Traveller traveller;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final paint = Paint()
      ..color = switch (traveller.type) {
        TravellerType.hero => gameRef.theme.travellerHeroColor,
        TravellerType.vilain => gameRef.theme.travellerVillainColor
      };

    add(
      CircleHitbox(
        radius: _travellerRadius,
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

    children.whereType<CircleHitbox>().single.radius = _travellerRadius;

    super.onGameResize(size);
  }

  void _updatePosition() {
    final offset = traveller.offset;

    position = traveller.cell
        .getOffsetFromScreenSize(offset, gameRef.size.toSize())
        .toVector2();
  }

  double get _travellerRadius {
    final travellerSizeFactor = game.theme.travellerSizeFactor;

    return math.min(
      game.size.x / game.theme.gridSize.width / 2 * travellerSizeFactor,
      game.size.y / game.theme.gridSize.height / 2 * travellerSizeFactor,
    );
  }
}
