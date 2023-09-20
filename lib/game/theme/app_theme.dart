import 'package:bullet_train/design/colors.dart';
import 'package:bullet_train/game/theme/game_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String defaultPolice = 'Avenir';

class AppTheme {
  static final _connectColors = ConnectColors();
  static final _baseTheme = ThemeData.dark();
  
  static final ThemeData themeData = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: _connectColors.background,
      elevation: 0,
    ),
    fontFamily: defaultPolice,
    primaryColor: _connectColors.primary,
    primaryColorDark: _connectColors.primaryDark,
    buttonTheme: _baseTheme.buttonTheme.copyWith(
      buttonColor: _connectColors.surface,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      textTheme: ButtonTextTheme.primary,
    ),
    scaffoldBackgroundColor: _connectColors.background,
    cardColor: _connectColors.surface,
    colorScheme: ColorScheme(
      primary: _connectColors.primary,
      primaryContainer: _connectColors.primaryDark,
      secondary: _connectColors.primary,
      surface: _connectColors.surface,
      background: _connectColors.background,
      error: _connectColors.error,
      onError: _connectColors.error,
      onPrimary: _connectColors.onPrimary,
      onSecondary: Colors.green,
      onSurface: _connectColors.onSurface,
      onBackground: _connectColors.onBackground,
      brightness: _baseTheme.brightness,
    ),
    extensions: [
      GameTheme(
        background: _connectColors.background,
        snakeHead: _connectColors.primaryDark,
        snakeBody: _connectColors.primary,
        walls: _connectColors.surface,
        gridOdd: _connectColors.surface,
        gridEvent: _connectColors.popup,
        gridSize: 17,
        speedInCellsPerSecond: 3,
      ),
    ],
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
