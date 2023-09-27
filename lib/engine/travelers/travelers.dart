import 'dart:math';
import 'dart:ui';

import 'package:bullet_train/engine/engine.dart';

enum TravelerType {
  vilain,
  hero,
}

class Travelers {
  Travelers({required GridSize gridSize, required CellsMatrix cellsMatrix})
      : _gridSize = gridSize,
        _matrix = cellsMatrix;

  final GridSize _gridSize;
  final CellsMatrix _matrix;

  final _random = Random(DateTime.now().millisecondsSinceEpoch);
  final _all = <Traveler>[];

  late final Set<Cell> _allOffsets = _generateOffsets();

  void addIfNeeded({
    required Train train,
    required void Function(Traveler traveler) onTravelerAdded,
  }) {
    if (!_all.any((p) => p.type == TravelerType.hero)) {
      final cars = Set<Cell>.from(
        train.bodies.map((body) => body.rail.cell),
      );
      final psngrCells = Set<Cell>.from(_all.map((p) => p.cell));

      final availableOffsets =
          _allOffsets.difference(cars).difference(psngrCells);

      if (availableOffsets.isEmpty) return;

      // Hero
      final heroCell = availableOffsets.toList(
        growable: false,
      )[_random.nextInt(availableOffsets.length)];
      final hero = Traveler(type: TravelerType.hero, cell: heroCell);

      availableOffsets.remove(heroCell);

      _all.add(hero);
      onTravelerAdded(hero);

      if (availableOffsets.isEmpty) return;

      // Vilains
      final vilains = _all.where((p) => p.type == TravelerType.vilain);

      while (vilains.length < train.bodies.length - 1) {
        final vilainCell = availableOffsets.toList(
          growable: false,
        )[_random.nextInt(availableOffsets.length)];
        final vilain = Traveler(
          type: TravelerType.vilain,
          cell: vilainCell,
        );

        availableOffsets.remove(vilainCell);

        _all.add(vilain);
        onTravelerAdded(vilain);

        if (availableOffsets.isEmpty) return;
      }
    }
  }

  void remove(Traveler traveler) => _all.remove(traveler);

  Set<Cell> _generateOffsets() {
    final result = <Cell>{};

    for (var x = 0; x < _gridSize.width; x++) {
      for (var y = 0; y < _gridSize.height; y++) {
        result.add(_matrix.getCell(x, y));
      }
    }

    return result;
  }
}

class Traveler {
  Traveler({required this.type, required this.cell});

  final TravelerType type;
  final Cell cell;

  Offset get offset => cell.rect.center;
}
