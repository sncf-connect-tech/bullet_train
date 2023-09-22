import 'dart:ui';

import 'package:bullet_train/models/models.dart';
import 'package:flutter/material.dart';

class GameTheme extends ThemeExtension<GameTheme> {
  GameTheme({
    required this.backgroundColor,
    required this.snakeHeadColor,
    required this.snakeBodyColor,
    required this.wallsColor,
    required this.cellOddColor,
    required this.cellEvenColor,
    required this.gridSize,
    required this.trainSizeFactor,
    required this.speedInCellsPerSecond,
  })  : assert(gridSize.width.isOdd, 'gridSize width must be odd'),
        assert(gridSize.height.isOdd, 'gridSize height must be odd');

  final Color backgroundColor;
  final Color snakeHeadColor;
  final Color snakeBodyColor;
  final Color wallsColor;
  final Color cellOddColor;
  final Color cellEvenColor;

  /// The size of the grid in pixels
  /// /!\ Must be odd
  final GridSize gridSize;
  final double trainSizeFactor;

  final double speedInCellsPerSecond;

  double get gridAspectRatio => gridSize.width / gridSize.height;

  @override
  ThemeExtension<GameTheme> copyWith({
    Color? backgroundColor,
    Color? snakeHeadColor,
    Color? snakeBodyColor,
    Color? wallsColor,
    Color? cellOddColor,
    Color? cellEvenColor,
    GridSize? gridSize,
    double? trainSizeFactor,
    double? speedInCellsPerSecond,
  }) =>
      GameTheme(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        snakeHeadColor: snakeHeadColor ?? this.snakeHeadColor,
        snakeBodyColor: snakeBodyColor ?? this.snakeBodyColor,
        wallsColor: wallsColor ?? this.wallsColor,
        cellOddColor: cellOddColor ?? this.cellOddColor,
        cellEvenColor: cellEvenColor ?? this.cellEvenColor,
        gridSize: gridSize ?? this.gridSize,
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
