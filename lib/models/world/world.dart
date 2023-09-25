import 'dart:collection';
import 'dart:math';
import 'dart:ui';

import 'package:bullet_train/models/models.dart';

class World {
  World({
    required GridSize gridSize,
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

  void addPassengerIfNeeded({
    required int trainSize,
    required void Function(Passenger passenger) onPassengerAdded,
  }) {
    if (!_passengers.any((p) => p.type == PassengerType.hero)) {
      final allOffsets = <Cell>{};
      for (var x = 0; x < gridSize.width; x++) {
        for (var y = 0; y < gridSize.height; y++) {
          allOffsets.add(_matrix.getCell(x, y));
        }
      }
      final cars = Set<Cell>.from(
        train.bodies.map((body) => body.rail.cell),
      );
      final psngrCells = Set<Cell>.from(_passengers.map((p) => p.cell));

      final availableOffsets =
          allOffsets.difference(cars).difference(psngrCells);

      if (availableOffsets.isEmpty) return;

      // Hero
      final heroCell = availableOffsets.toList(
        growable: false,
      )[_random.nextInt(availableOffsets.length)];
      final hero = Passenger(type: PassengerType.hero, cell: heroCell);

      availableOffsets.remove(heroCell);

      _passengers.add(hero);
      onPassengerAdded(hero);

      // Vilains
      final vilains = _passengers.where((p) => p.type == PassengerType.vilain);

      while (vilains.length < trainSize - 1) {
        final vilainCell = availableOffsets.toList(
          growable: false,
        )[_random.nextInt(availableOffsets.length)];

        availableOffsets.remove(vilainCell);

        final vilain = Passenger(
          type: PassengerType.vilain,
          cell: vilainCell,
        );

        _passengers.add(vilain);
        onPassengerAdded(vilain);
      }
    }
  }

  void removePassenger(Passenger passenger) => _passengers.remove(passenger);
}
