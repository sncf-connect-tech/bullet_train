import 'dart:collection';
import 'dart:math';
import 'dart:ui';

import 'package:bullet_train/engine/engine.dart';

class World {
  World({
    required GridSize gridSize,
    required this.onScoreIncrease,
    required this.onScoreDecrease,
  })  : _matrix = CellsMatrix(
          gridSize: gridSize,
        ),
        _travellers = [] {
    train = Train(
      startCell: _matrix.center(),
    );
  }

  late final Train train;
  final CellsMatrix _matrix;
  final Travellers _travellers;
  final VoidCallback onScoreIncrease;
  final VoidCallback onScoreDecrease;

  UnmodifiableListView<Cell> get cells => _matrix.cells;
  Travellers get travellers => _travellers;

  Size get gridSize => Size(
        _matrix.gridSize.width.toDouble(),
        _matrix.gridSize.height.toDouble(),
      );

  void moveForward(
    double dtPixels, {
    required void Function(TrainCar car) onNewDisplayedCar,
  }) =>
      train.moveForward(dtPixels, onNewDisplayedCar: onNewDisplayedCar);

  void moveNextTo(Position position) => train.moveNextTo(position);

  void addTrainCar() => train.addCar();
  void removeTrainCar() => train.removeCar();

  final _random = Random(DateTime.now().millisecondsSinceEpoch);

  late final Set<Cell> _allOffsets = _generateOffsets();

  void addTravellerIfNeeded({
    required int trainSize,
    required void Function(Traveller traveller) onTravellerAdded,
  }) {
    if (!_travellers.any((p) => p.type == TravellerType.hero)) {
      final cars = Set<Cell>.from(
        train.bodies.map((body) => body.rail.cell),
      );
      final psngrCells = Set<Cell>.from(_travellers.map((p) => p.cell));

      final availableOffsets =
          _allOffsets.difference(cars).difference(psngrCells);

      if (availableOffsets.isEmpty) return;

      // Hero
      final heroCell = availableOffsets.toList(
        growable: false,
      )[_random.nextInt(availableOffsets.length)];
      final hero = Traveller(type: TravellerType.hero, cell: heroCell);

      availableOffsets.remove(heroCell);

      _travellers.add(hero);
      onTravellerAdded(hero);

      if (availableOffsets.isEmpty) return;

      // Vilains
      final vilains = _travellers.where((p) => p.type == TravellerType.vilain);

      while (vilains.length < trainSize - 1) {
        final vilainCell = availableOffsets.toList(
          growable: false,
        )[_random.nextInt(availableOffsets.length)];
        final vilain = Traveller(
          type: TravellerType.vilain,
          cell: vilainCell,
        );

        availableOffsets.remove(vilainCell);

        _travellers.add(vilain);
        onTravellerAdded(vilain);

        if (availableOffsets.isEmpty) return;
      }
    }
  }

  void removeTraveller(Traveller traveller) => _travellers.remove(traveller);

  Set<Cell> _generateOffsets() {
    final result = <Cell>{};

    for (var x = 0; x < gridSize.width; x++) {
      for (var y = 0; y < gridSize.height; y++) {
        result.add(_matrix.getCell(x, y));
      }
    }

    return result;
  }
}
