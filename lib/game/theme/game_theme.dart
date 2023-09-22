import 'dart:ui';

import 'package:bullet_train/models/models.dart';
import 'package:flutter/material.dart';

class GameTheme extends ThemeExtension<GameTheme> {
  GameTheme({
    required this.background,
    required this.snakeHead,
    required this.snakeBody,
    required this.walls,
    required this.gridOdd,
    required this.gridEvent,
    required this.gridSize,
    required this.trainSizeFactor,
    required this.speedInCellsPerSecond,
  })  : assert(gridSize.width.isOdd, 'gridSize width must be odd'),
        assert(gridSize.height.isOdd, 'gridSize height must be odd');

  final Color background;
  final Color snakeHead;
  final Color snakeBody;
  final Color walls;
  final Color gridOdd;
  final Color gridEvent;

  /// The size of the grid in pixels
  /// /!\ Must be odd
  final GridSize gridSize;
  final double trainSizeFactor;

  final double speedInCellsPerSecond;

  double get gridAspectRatio => gridSize.width / gridSize.height;

  @override
  ThemeExtension<GameTheme> copyWith({
    Color? background,
    Color? snakeHead,
    Color? snakeBody,
    Color? walls,
    Color? gridOdd,
    Color? gridEvent,
    GridSize? gridSize,
    double? trainSizeFactor,
    double? speedInCellsPerSecond,
  }) =>
      GameTheme(
        background: background ?? this.background,
        snakeHead: snakeHead ?? this.snakeHead,
        snakeBody: snakeBody ?? this.snakeBody,
        walls: walls ?? this.walls,
        gridOdd: gridOdd ?? this.gridOdd,
        gridEvent: gridEvent ?? this.gridEvent,
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
      background: Color.lerp(background, other.background, t),
      snakeHead: Color.lerp(snakeHead, other.snakeHead, t),
      snakeBody: Color.lerp(snakeBody, other.snakeBody, t),
      walls: Color.lerp(walls, other.walls, t),
      gridOdd: Color.lerp(gridOdd, other.gridOdd, t),
      gridEvent: Color.lerp(gridEvent, other.gridEvent, t),
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
