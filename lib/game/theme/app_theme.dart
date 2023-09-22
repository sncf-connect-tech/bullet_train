import 'package:bullet_train/design/colors.dart';
import 'package:bullet_train/game/theme/game_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String defaultPolice = 'Avenir';

class AppTheme {
  static final _baseTheme = ThemeData.dark();
  
  static final ThemeData themeData = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: ConnectColors.background,
      elevation: 0,
    ),
    fontFamily: defaultPolice,
    primaryColor: ConnectColors.primary,
    primaryColorDark: ConnectColors.primaryDark,
    buttonTheme: _baseTheme.buttonTheme.copyWith(
      buttonColor: ConnectColors.error,
      highlightColor: Colors.transparent,
      textTheme: ButtonTextTheme.primary,
    ),
    scaffoldBackgroundColor: ConnectColors.background,
    cardColor: ConnectColors.surface,
    colorScheme: ColorScheme(
      primary: ConnectColors.primary,
      primaryContainer: ConnectColors.primaryDark,
      secondary: ConnectColors.primary,
      surface: ConnectColors.surface,
      background: ConnectColors.background,
      error: ConnectColors.error,
      onError: ConnectColors.error,
      onPrimary: ConnectColors.onPrimary,
      onSecondary: Colors.green,
      onSurface: ConnectColors.onSurface,
      onBackground: ConnectColors.onBackground,
      brightness: _baseTheme.brightness,
    ),
    extensions: [
      GameTheme(
        background: ConnectColors.background,
        snakeHead: ConnectColors.primaryDark,
        snakeBody: ConnectColors.primary,
        walls: ConnectColors.surface,
        gridOdd: ConnectColors.surface,
        gridEvent: ConnectColors.popup,
        gridSize: 17,
        speedInCellsPerSecond: 3,
      ),
    ],
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
