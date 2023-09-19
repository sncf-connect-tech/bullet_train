import 'package:bullet_train/models/foundation/foundation.dart';
import 'package:bullet_train/models/train/train.dart';

class World {
  World({
    required int gridSize,
    required double screenSize,
  }) : cells = CellsMatrix(gridSize: gridSize, screenSize: screenSize) {
    train = Train(
      startCell: cells.center(),
    );
  }

  late final Train train;
  final CellsMatrix cells;

  void moveForward(
    double dtPixels, {
    required void Function(TrainCar car) onNewDisplayedCar,
  }) =>
      train.moveForward(dtPixels, onNewDisplayedCar: onNewDisplayedCar);

  void moveNextTo(Position position) => train.moveNextTo(position);

  void addTrainCar() => train.addCar();

  void onGameResize(double scale) {
    cells.onGameResize(scale);
    train.onGameResize(scale);
  }
}
