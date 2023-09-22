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

  final _random = Random(DateTime.now().millisecondsSinceEpoch);

  void generatePassengers(double dt) {
    if (_passengers.isEmpty) {
      final allOffsets = <Cell>{};
      for (var x = 0; x < gridSize.width; x++) {
        for (var y = 0; y < gridSize.height; y++) {
          allOffsets.add(_matrix.getCell(x, y));
        }
      }
      final cars = Set<Cell>.from(
        train.bodies.map((body) => body.rail.cell),
      );
      final availableOffsets = allOffsets.intersection(cars).toList();

      if (availableOffsets.isEmpty) return;
      final result = availableOffsets[_random.nextInt(availableOffsets.length)];
      final passengerType =
          switch (_random.nextInt(PassengerType.values.length)) {
        0 => PassengerType.badGuy,
        1 => PassengerType.goodGuy,
        _ => PassengerType.badGuy,
      };

      _passengers
          .add(Passenger(type: passengerType, position: result.rect.center));
    }
  }
}
