import 'dart:async';

import 'package:bullet_train/game/bullet_train.dart';
import 'package:bullet_train/models/models.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class GameBackgroundComponent extends PositionComponent
    with HasGameRef<VeryGoodFlameGame> {
  GameBackgroundComponent() : super(priority: GameLayer.background.priority);

  @override
  FutureOr<void> onLoad() {
    for (final cell in game.world.cells.cells) {
      add(
        RectangleComponent.fromRect(
          cell.rect,
          paint: _getPaintFromCellParity(cell.parity),
        ),
      );
    }
  }

  @override
  void onGameResize(Vector2 size) {
    final cellsRendered = children.whereType<RectangleComponent>().toList();
    final cells = game.world.cells.cells;

    assert(
      cellsRendered.length <= cellsRendered.length,
      'Cells length mismatch',
    );

    for (var i = 0; i < cellsRendered.length; i++) {
      cellsRendered[i].setByRect(cells[i].rect);
    }

    super.onGameResize(size);
  }

  Paint _getPaintFromCellParity(CellParity parity) {
    final theme = game.theme;
    final paint = Paint();

    switch (parity) {
      case CellParity.odd:
        paint.color = theme.gridOdd;
      case CellParity.even:
        paint.color = theme.gridEvent;
    }

    return paint;
  }
}
