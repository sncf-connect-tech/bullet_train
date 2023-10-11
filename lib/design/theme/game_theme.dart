import 'dart:ui';

import 'package:bullet_train/engine/engine.dart';
import 'package:flutter/material.dart';

class GameTheme extends ThemeExtension<GameTheme> {
  GameTheme({
    required this.backgroundColor,
    required this.snakeHeadColor,
    required this.snakeBodyColor,
    required this.travelerHeroColor,
    required this.travelerVillainColor,
    required this.wallsColor,
    required this.cellOddColor,
    required this.cellEvenColor,
    required this.gridSize,
    required this.travelerSizeFactor,
    required this.trainSizeFactor,
    required this.hitBoxSizeFactor,
  })  : assert(gridSize.width.isOdd, 'gridSize width must be odd'),
        assert(gridSize.height.isOdd, 'gridSize height must be odd');

  final Color backgroundColor;
  final Color snakeHeadColor;
  final Color snakeBodyColor;
  final Color travelerHeroColor;
  final Color travelerVillainColor;
  final Color wallsColor;
  final Color cellOddColor;
  final Color cellEvenColor;

  /// The size of the grid in pixels
  /// /!\ Must be odd
  final GridSize gridSize;
  final double travelerSizeFactor;
  final double trainSizeFactor;
  final double hitBoxSizeFactor;

  double get gridAspectRatio => gridSize.width / gridSize.height;

  static GameTheme defaultGameTheme = GameTheme(
    backgroundColor: Colors.grey,
    snakeHeadColor: Colors.lightBlueAccent,
    snakeBodyColor: Colors.blueAccent,
    wallsColor: Colors.green,
    cellOddColor: Colors.blueGrey,
    cellEvenColor: Colors.yellow,
    gridSize: (width: 17, height: 33),
    travelerHeroColor: Colors.green,
    travelerVillainColor: Colors.red,
    travelerSizeFactor: 0.5,
    trainSizeFactor: 0.95,
    hitBoxSizeFactor: 0.7,
  );

  @override
  ThemeExtension<GameTheme> copyWith({
    Color? backgroundColor,
    Color? snakeHeadColor,
    Color? snakeBodyColor,
    Color? travelerHeroColor,
    Color? travelerVillainColor,
    Color? wallsColor,
    Color? cellOddColor,
    Color? cellEvenColor,
    GridSize? gridSize,
    double? travelerSizeFactor,
    double? trainSizeFactor,
    double? hitBoxSizeFactor,
  }) =>
      GameTheme(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        snakeHeadColor: snakeHeadColor ?? this.snakeHeadColor,
        snakeBodyColor: snakeBodyColor ?? this.snakeBodyColor,
        travelerHeroColor: travelerHeroColor ?? this.travelerHeroColor,
        travelerVillainColor: travelerVillainColor ?? this.travelerVillainColor,
        wallsColor: wallsColor ?? this.wallsColor,
        cellOddColor: cellOddColor ?? this.cellOddColor,
        cellEvenColor: cellEvenColor ?? this.cellEvenColor,
        gridSize: gridSize ?? this.gridSize,
        travelerSizeFactor: travelerSizeFactor ?? this.travelerSizeFactor,
        trainSizeFactor: trainSizeFactor ?? this.trainSizeFactor,
        hitBoxSizeFactor: hitBoxSizeFactor ?? this.hitBoxSizeFactor,
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
      travelerHeroColor:
          Color.lerp(travelerHeroColor, other.travelerHeroColor, t),
      travelerVillainColor: Color.lerp(
        travelerVillainColor,
        other.travelerVillainColor,
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
      travelerSizeFactor: lerpDouble(
        travelerSizeFactor,
        other.travelerSizeFactor,
        t,
      ),
      trainSizeFactor: lerpDouble(
        trainSizeFactor,
        other.trainSizeFactor,
        t,
      ),
    );
  }
}

extension GameThemeExtension on ThemeData {
  GameTheme get game => extension<GameTheme>()!;
}
