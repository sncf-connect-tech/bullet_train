import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

mixin BackgroundParity on HasGameRef<BulletTrainGame> {
  @protected
  Paint getPaintFromCellParity(CellParity parity) {
    final paint = Paint();
    switch (parity) {
      case CellParity.odd:
        paint.color = gameRef.theme.cellOddColor;
      case CellParity.even:
        paint.color = gameRef.theme.cellEvenColor;
    }
    return paint;
  }
}
