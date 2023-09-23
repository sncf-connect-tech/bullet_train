import 'dart:math' as math;

import 'package:bullet_train/game/game.dart';
import 'package:bullet_train/models/models.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/painting.dart';

class PassengerComponent extends CircleComponent with HasGameRef<BulletTrain> {
  PassengerComponent({
    required this.passenger,
  }) : super(priority: GameLayer.passenger.priority);

  final Passenger passenger;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final paint = Paint()
      ..color = switch (passenger.type) {
        PassengerType.hero => gameRef.theme.passengerHeroColor,
        PassengerType.vilain => gameRef.theme.passengerVilainColor
      };

    add(
      CircleHitbox(
        radius: _passengerRadius,
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

    children.whereType<CircleHitbox>().single.radius = _passengerRadius;

    super.onGameResize(size);
  }

  void _updatePosition() {
    final offset = passenger.offset;

    position = passenger.cell
        .getOffsetFromScreenSize(offset, gameRef.size.toSize())
        .toVector2();
  }

  double get _passengerRadius {
    final passengerSizeFactor = game.theme.passengerSizeFactor;

    return math.min(
      game.size.x / game.theme.gridSize.width / 2 * passengerSizeFactor,
      game.size.y / game.theme.gridSize.height / 2 * passengerSizeFactor,
    );
  }
}
