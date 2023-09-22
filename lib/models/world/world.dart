import 'dart:collection';
import 'dart:ui';

import 'package:bullet_train/models/foundation/foundation.dart';
import 'package:bullet_train/models/train/train.dart';

class World {
  World({
    required GridSize gridSize,
  }) : _matrix = CellsMatrix(
          gridSize: gridSize,
        ) {
    train = Train(
      startCell: _matrix.center(),
    );
  }

  late final Train train;
  final CellsMatrix _matrix;

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
}
