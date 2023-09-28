import 'dart:async';

import 'package:bullet_train/design/game_theme.dart';
import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/bullet_train.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class GameBackgroundComponent extends PositionComponent
    with HasGameRef<BulletTrain> {
  GameBackgroundComponent() : super(priority: GameLayer.background.priority);

  GameTheme get _theme => gameRef.theme;
  Vector2 get _parentSize => gameRef.size;

  @override
  FutureOr<void> onLoad() {
    for (final cell in game.engineWorld.cells) {
      add(
        RectangleComponent.fromRect(
          cell.getRectFromScreenSize(_parentSize.toSize()),
          paint: _getPaintFromCellParity(cell.parity),
        ),
      );
    }
  }

  @override
  void onParentResize(Vector2 maxSize) {
    final cellsRendered = children.whereType<RectangleComponent>().toList();
    final cells = game.engineWorld.cells;

    assert(
      cellsRendered.length <= cellsRendered.length,
      'Cells length mismatch',
    );

    for (var i = 0; i < cellsRendered.length; i++) {
      cellsRendered[i]
          .setByRect(cells[i].getRectFromScreenSize(_parentSize.toSize()));
    }

    super.onParentResize(maxSize);
  }

  Paint _getPaintFromCellParity(CellParity parity) {
    final paint = Paint();

    switch (parity) {
      case CellParity.odd:
        paint.color = _theme.cellOddColor;
      case CellParity.even:
        paint.color = _theme.cellEvenColor;
    }

    return paint;
  }
}
