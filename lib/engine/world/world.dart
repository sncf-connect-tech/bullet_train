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
        _passengers = [] {
    train = Train(
      startCell: _matrix.center(),
    );
  }

  late final Train train;
  final CellsMatrix _matrix;
  final Passengers _passengers;
  final VoidCallback onScoreIncrease;
  final VoidCallback onScoreDecrease;

  UnmodifiableListView<Cell> get cells => _matrix.cells;
  Passengers get passengers => _passengers;

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

  void addPassengerIfNeeded({
    required int trainSize,
    required void Function(Passenger passenger) onPassengerAdded,
  }) {
    if (!_passengers.any((p) => p.type == PassengerType.hero)) {
      final cars = Set<Cell>.from(
        train.bodies.map((body) => body.rail.cell),
      );
      final psngrCells = Set<Cell>.from(_passengers.map((p) => p.cell));

      final availableOffsets =
          _allOffsets.difference(cars).difference(psngrCells);

      if (availableOffsets.isEmpty) return;

      // Hero
      final heroCell = availableOffsets.toList(
        growable: false,
      )[_random.nextInt(availableOffsets.length)];
      final hero = Passenger(type: PassengerType.hero, cell: heroCell);

      availableOffsets.remove(heroCell);

      _passengers.add(hero);
      onPassengerAdded(hero);

      if (availableOffsets.isEmpty) return;

      // Vilains
      final vilains = _passengers.where((p) => p.type == PassengerType.vilain);

      while (vilains.length < trainSize - 1) {
        final vilainCell = availableOffsets.toList(
          growable: false,
        )[_random.nextInt(availableOffsets.length)];
        final vilain = Passenger(
          type: PassengerType.vilain,
          cell: vilainCell,
        );

        availableOffsets.remove(vilainCell);

        _passengers.add(vilain);
        onPassengerAdded(vilain);

        if (availableOffsets.isEmpty) return;
      }
    }
  }

  void removePassenger(Passenger passenger) => _passengers.remove(passenger);

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
