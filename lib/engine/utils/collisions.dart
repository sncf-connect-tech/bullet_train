import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

extension CollidableVisibleExtensions on HasGameRef<BulletTrainGame> {
  void makeCollidableVisible(ShapeHitbox hitbox) {
    final paint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3 / gameRef.theme.gridSize.width;

    hitbox
      ..priority = 1000
      ..renderShape = true
      ..paint = paint;
  }
}
