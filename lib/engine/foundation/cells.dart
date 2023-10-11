// ignore_for_file: must_be_immutable

import 'dart:collection';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';

enum CellParity {
  odd,
  even;

  CellParity get opposite =>
      this == CellParity.odd ? CellParity.even : CellParity.odd;
}

typedef GridSize = ({int width, int height});

extension GridSizeToVector2Extension on GridSize {
  Vector2 toVector2() => Vector2(width.toDouble(), height.toDouble());
}

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

    for (var x = 0; x < _cells.length; x++) {
      _cells[x][0]._up = _cells[x][_cells[x].length - 1];
      _cells[x][_cells[x].length - 1]._down = _cells[x][0];
    }

    for (var y = 0; y < _cells[0].length; y++) {
      _cells[0][y]._left = _cells[_cells.length - 1][y];
      _cells[_cells.length - 1][y]._right = _cells[0][y];
    }
  }

  final GridSize gridSize;
  final List<List<Cell>> _cells;
  late final Set<Cell> allOffsets = _generateOffsets();
  final _random = Random(DateTime.now().millisecondsSinceEpoch);

  Cell randomFrom(Set<Cell> cells) =>
      cells.toList(growable: false)[_random.nextInt(cells.length)];

  UnmodifiableListView<Cell> get cells =>
      UnmodifiableListView(_cells.expand((list) => list));

  Cell getCell(int x, int y) => _cells[x][y];

  Cell center() {
    return _cells[(gridSize.width ~/ 2)][(gridSize.height ~/ 2)];
  }

  Set<Cell> _generateOffsets() {
    final result = <Cell>{};
    for (var x = 0; x < gridSize.width; x++) {
      for (var y = 0; y < gridSize.height; y++) {
        result.add(getCell(x, y));
      }
    }
    return result;
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

  late Cell? _up;
  late Cell? _down;
  late Cell? _left;
  late Cell? _right;

  Cell get up => _up!;

  Cell get down => _down!;

  Cell get left => _left!;

  Cell get right => _right!;
}
