import 'dart:ui';

enum CellParity {
  odd,
  even;

  CellParity get opposite =>
      this == CellParity.odd ? CellParity.even : CellParity.odd;
}

class CellsMatrix {
  CellsMatrix({
    required this.gridSize,
    required double screenSize,
  }) : _cells = _generateCells(gridSize, screenSize) {
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

  final int gridSize;
  final List<List<Cell>> _cells;

  List<Cell> get cells => _cells.expand((list) => list).toList(growable: false);

  Cell getCell(int x, int y) => _cells[x][y];

  Cell center() {
    final gridCenter = (gridSize / 2).floor();
    
    return _cells[gridCenter][gridCenter];
  }

  void onGameResize(double scale) {
    for (var x = 0; x < gridSize; x++) {
      for (var y = 0; y < gridSize; y++) {
        final rect = _cells[x][y]._rect;
        _cells[x][y]._rect = Rect.fromLTWH(
          rect.top * scale,
          rect.left * scale,
          rect.width * scale,
          rect.height * scale,
        );
      }
    }
  }

  static List<List<Cell>> _generateCells(int gridSize, double screenSize) {
    final cellSize = screenSize / gridSize;
    var xParity = CellParity.odd;

    return List.generate(
      gridSize,
      (x) {
        xParity = xParity.opposite;
        var parity = xParity;
        return List.generate(
          gridSize,
          (y) {
            parity = parity.opposite;

            return Cell._(
              parity: parity,
              rect: Rect.fromLTWH(
                x * cellSize,
                y * cellSize,
                cellSize,
                cellSize,
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
    required Rect rect,
  }) : _rect = rect;

  final CellParity parity;
  Rect _rect;

  Cell? _up;
  Cell? _down;
  Cell? _left;
  Cell? _right;

  Rect get rect => _rect;

  Cell? get up => _up;
  Cell? get down => _down;
  Cell? get left => _left;
  Cell? get right => _right;
}
