import 'dart:ui';

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
    required this.speedInCellsPerSecond,
  }) : assert(gridSize.isOdd, 'gridSize must be odd');

  final Color background;
  final Color snakeHead;
  final Color snakeBody;
  final Color walls;
  final Color gridOdd;
  final Color gridEvent;

  final double speedInCellsPerSecond;

  /// The size of the grid in pixels
  /// /!\ Must be odd
  final int gridSize;

  @override
  ThemeExtension<GameTheme> copyWith({
    Color? background,
    Color? snakeHead,
    Color? snakeBody,
    Color? walls,
    Color? gridOdd,
    Color? gridEvent,
    int? gridSize,
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
      gridSize: lerpDouble(gridSize.toDouble(), other.gridSize.toDouble(), t)
          ?.round(),
      speedInCellsPerSecond: lerpDouble(
        speedInCellsPerSecond,
        other.speedInCellsPerSecond,
        t,
      ),
    );
  }
}
