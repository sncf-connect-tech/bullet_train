// ignore_for_file: must_be_immutable

import 'dart:collection';
import 'dart:ui';

import 'package:flutter/foundation.dart';

enum CellParity {
  odd,
  even;

  CellParity get opposite =>
      this == CellParity.odd ? CellParity.even : CellParity.odd;
}

typedef GridSize = ({int width, int height});

class CellsMatrix {
  CellsMatrix({
    required this.gridSize,
  }) : _cells = _generateCells(gridSize) {
    for (var x = 0; x < _cells.length; x++) {
      for (var y = 0; y < _cells[x].length; y++) {
        final cell = getCell(x, y);
        if (x > 0) {
          cell._left = getCell(x - 1, y);
        }
        if (x < _cells.length - 1) {
          cell._right = getCell(x + 1, y);
        }
        if (y > 0) {
          cell._up = getCell(x, y - 1);
        }
        if (y < _cells[x].length - 1) {
          cell._down = getCell(x, y + 1);
        }
      }
    }
  }

  final GridSize gridSize;
  final List<List<Cell>> _cells;

  UnmodifiableListView<Cell> get cells =>
      UnmodifiableListView(_cells.expand((list) => list));

  Cell getCell(int x, int y) => _cells[x][y];

  Cell center() {
    return _cells[(gridSize.width ~/ 2)][(gridSize.height ~/ 2)];
  }

  static List<List<Cell>> _generateCells(GridSize gridSize) {
    var xParity = CellParity.odd;

    return List.generate(
      gridSize.width,
      (x) {
        xParity = xParity.opposite;
        var parity = xParity;
        return List.generate(
          gridSize.height,
          (y) {
            parity = parity.opposite;

            return Cell._(
              gridSize: Size(
                gridSize.width.toDouble(),
                gridSize.height.toDouble(),
              ),
              parity: parity,
              rect: Rect.fromLTWH(
                x.toDouble(),
                y.toDouble(),
                1,
                1,
              ),
            );
          },
        );
      },
    );
  }
}

@immutable
class Cell {
  Cell._({
    required this.parity,
    required this.rect,
    required Size gridSize,
  }) : _gridSize = gridSize;

  final CellParity parity;
  final Rect rect;
  final Size _gridSize;

  Rect getRectFromScreenSize(Size screenSize) => Rect.fromLTWH(
        rect.left * screenSize.width / _gridSize.width,
        rect.top * screenSize.height / _gridSize.height,
        rect.width * screenSize.width / _gridSize.width,
        rect.height * screenSize.height / _gridSize.height,
      );

  Cell? _up;
  Cell? _down;
  Cell? _left;
  Cell? _right;

  Cell? get up => _up;
  Cell? get down => _down;
  Cell? get left => _left;
  Cell? get right => _right;

  Offset getOffsetFromScreenSize(Offset offset, Size screenSize) => Offset(
        offset.dx * screenSize.width / _gridSize.width,
        offset.dy * screenSize.height / _gridSize.height,
      );
}
