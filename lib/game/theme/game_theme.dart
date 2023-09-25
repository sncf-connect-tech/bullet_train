import 'dart:ui';

import 'package:bullet_train/models/models.dart';
import 'package:flutter/material.dart';

class GameTheme extends ThemeExtension<GameTheme> {
  GameTheme({
    required this.backgroundColor,
    required this.snakeHeadColor,
    required this.snakeBodyColor,
    required this.passengerHeroColor,
    required this.passengerVillainColor,
    required this.wallsColor,
    required this.cellOddColor,
    required this.cellEvenColor,
    required this.gridSize,
    required this.passengerSizeFactor,
    required this.trainSizeFactor,
    required this.speedInCellsPerSecond,
  })  : assert(gridSize.width.isOdd, 'gridSize width must be odd'),
        assert(gridSize.height.isOdd, 'gridSize height must be odd');

  final Color backgroundColor;
  final Color snakeHeadColor;
  final Color snakeBodyColor;
  final Color passengerHeroColor;
  final Color passengerVillainColor;
  final Color wallsColor;
  final Color cellOddColor;
  final Color cellEvenColor;

  /// The size of the grid in pixels
  /// /!\ Must be odd
  final GridSize gridSize;
  final double passengerSizeFactor;
  final double trainSizeFactor;

  final double speedInCellsPerSecond;

  double get gridAspectRatio => gridSize.width / gridSize.height;

  static GameTheme defaultGameTheme = GameTheme(
    backgroundColor: Colors.grey,
    snakeHeadColor: Colors.lightBlueAccent,
    snakeBodyColor: Colors.blueAccent,
    wallsColor: Colors.green,
    cellOddColor: Colors.blueGrey,
    cellEvenColor: Colors.yellow,
    gridSize: (width: 17, height: 33),
    speedInCellsPerSecond: 2,
    passengerHeroColor: Colors.green,
    passengerVillainColor: Colors.red,
    passengerSizeFactor: 0.5,
    trainSizeFactor: 0.7,
  );

  @override
  ThemeExtension<GameTheme> copyWith({
    Color? backgroundColor,
    Color? snakeHeadColor,
    Color? snakeBodyColor,
    Color? passengerHeroColor,
    Color? passengerVillainColor,
    Color? wallsColor,
    Color? cellOddColor,
    Color? cellEvenColor,
    GridSize? gridSize,
    double? passengerSizeFactor,
    double? trainSizeFactor,
    double? speedInCellsPerSecond,
  }) =>
      GameTheme(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        snakeHeadColor: snakeHeadColor ?? this.snakeHeadColor,
        snakeBodyColor: snakeBodyColor ?? this.snakeBodyColor,
        passengerHeroColor: passengerHeroColor ?? this.passengerHeroColor,
        passengerVillainColor:
            passengerVillainColor ?? this.passengerVillainColor,
        wallsColor: wallsColor ?? this.wallsColor,
        cellOddColor: cellOddColor ?? this.cellOddColor,
        cellEvenColor: cellEvenColor ?? this.cellEvenColor,
        gridSize: gridSize ?? this.gridSize,
        passengerSizeFactor: passengerSizeFactor ?? this.passengerSizeFactor,
        trainSizeFactor: trainSizeFactor ?? this.trainSizeFactor,
        speedInCellsPerSecond:
            speedInCellsPerSecond ?? this.speedInCellsPerSecond,
      );

  @override
  ThemeExtension<GameTheme> lerp(
    covariant GameTheme? other,
    double t,
  ) {
    if (other == null) return this;

    return copyWith(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      snakeHeadColor: Color.lerp(snakeHeadColor, other.snakeHeadColor, t),
      snakeBodyColor: Color.lerp(snakeBodyColor, other.snakeBodyColor, t),
      passengerHeroColor:
          Color.lerp(passengerHeroColor, other.passengerHeroColor, t),
      passengerVillainColor: Color.lerp(
        passengerVillainColor,
        other.passengerVillainColor,
        t,
      ),
      wallsColor: Color.lerp(wallsColor, other.wallsColor, t),
      cellOddColor: Color.lerp(cellOddColor, other.cellOddColor, t),
      cellEvenColor: Color.lerp(cellEvenColor, other.cellEvenColor, t),
      gridSize: (
        width: lerpDouble(
              gridSize.width.toDouble(),
              other.gridSize.width.toDouble(),
              t,
            )?.round() ??
            other.gridSize.width,
        height: lerpDouble(
              gridSize.height.toDouble(),
              other.gridSize.height.toDouble(),
              t,
            )?.round() ??
            other.gridSize.height,
      ),
      passengerSizeFactor: lerpDouble(
        passengerSizeFactor,
        other.passengerSizeFactor,
        t,
      ),
      trainSizeFactor: lerpDouble(
        trainSizeFactor,
        other.trainSizeFactor,
        t,
      ),
      speedInCellsPerSecond: lerpDouble(
        speedInCellsPerSecond,
        other.speedInCellsPerSecond,
        t,
      ),
    );
  }
}

extension GameThemeExtension on ThemeData {
  GameTheme get game => extension<GameTheme>()!;
}
