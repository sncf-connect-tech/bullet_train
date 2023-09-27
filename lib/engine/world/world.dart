import 'dart:collection';
import 'dart:ui';

import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/shared/difficulty.dart';

/// The world of the game that contains the train and the travelers.
/// [gridSize] define the size of the grid in the world.
/// To handle score, [onScoreIncrease] and [onScoreDecrease] are called.
class World {
  World({
    required GridSize gridSize,
    required this.initialNumberOfCars,
    required this.difficulty,
    required this.onScoreIncrease,
    required this.onScoreDecrease,
  }) : _matrix = CellsMatrix(
          gridSize: gridSize,
        ) {
    train = Train(
      startCell: _matrix.center(),
      initialNumberOfCars: initialNumberOfCars,
    );
    _travelers = Travelers(
      gridSize: gridSize,
      cellsMatrix: _matrix,
      difficulty: difficulty,
    );
  }

  final CellsMatrix _matrix;
  late final Travelers _travelers;

  /// The train moving in the world.
  late final Train train;

  /// the initial number of train cars
  final int initialNumberOfCars;

  /// The game difficulty
  final Difficulty difficulty;

  /// Called when score is increased.
  final VoidCallback onScoreIncrease;

  /// Called when score is decreased.
  final VoidCallback onScoreDecrease;

  /// The cells matrix of the world.
  UnmodifiableListView<Cell> get cells => _matrix.cells;

  /// The travelers in the world.
  Travelers get travelers => _travelers;

  /// Size of the grid.
  Size get gridSize => Size(
        _matrix.gridSize.width.toDouble(),
        _matrix.gridSize.height.toDouble(),
      );

  /// Move forward train by [dtPixels] pixels.
  /// When a new car is displayed, [onNewDisplayedCar] is called.
  void moveForward(
    double dtPixels, {
    required void Function(TrainCar car) onNewDisplayedCar,
  }) =>
      train.moveForward(dtPixels, onNewDisplayedCar: onNewDisplayedCar);

  /// Move train to [position] in next cell.
  void moveNextTo(Position position) => train.moveNextTo(position);

  /// Add car to train.
  void addTrainCar() => train.addCar();

  /// Remove car from train.
  void removeTrainCar() => train.removeCar();

  /// Add traveler to world if needed.
  /// When a traveler is added, [onTravelerAdded] is called.
  void addTravelerIfNeeded({
    required void Function(Traveler traveler) onTravelerAdded,
  }) =>
      _travelers.addIfNeeded(
        train: train,
        onTravelerAdded: onTravelerAdded,
      );

  /// Remove traveler from world.
  void removeTraveler(Traveler traveler) => _travelers.remove(traveler);
}
