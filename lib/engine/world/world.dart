import 'dart:collection';
import 'dart:ui';

import 'package:bullet_train/engine/engine.dart';

class World {
  World({
    required GridSize gridSize,
    required this.onScoreIncrease,
    required this.onScoreDecrease,
  }) : _matrix = CellsMatrix(
          gridSize: gridSize,
        ) {
    train = Train(
      startCell: _matrix.center(),
    );
    _travelers = Travelers(gridSize: gridSize, cellsMatrix: _matrix);
  }

  final CellsMatrix _matrix;
  late final Train train;
  late final Travelers _travelers;
  final VoidCallback onScoreIncrease;
  final VoidCallback onScoreDecrease;

  UnmodifiableListView<Cell> get cells => _matrix.cells;
  Travelers get travelers => _travelers;

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

  void addTravelerIfNeeded({
    required void Function(Traveler traveler) onTravelerAdded,
  }) =>
      _travelers.addIfNeeded(
        train: train,
        onTravelerAdded: onTravelerAdded,
      );
  void removeTraveler(Traveler traveler) => _travelers.remove(traveler);
}
