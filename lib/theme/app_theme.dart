import 'package:bullet_train/design/colors.dart';
import 'package:bullet_train/theme/game_theme.dart';
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
      onSecondary: ConnectColors.success,
      onSurface: ConnectColors.onSurface,
      onBackground: ConnectColors.onBackground,
      brightness: _baseTheme.brightness,
    ),
    extensions: [
      GameTheme(
        backgroundColor: ConnectColors.background,
        snakeHeadColor: ConnectColors.primaryDark,
        snakeBodyColor: ConnectColors.primary,
        passengerHeroColor: ConnectColors.success,
        passengerVillainColor: ConnectColors.error,
        wallsColor: ConnectColors.surface,
        cellOddColor: ConnectColors.surface,
        cellEvenColor: ConnectColors.popup,
        gridSize: (width: 11, height: 11),
        passengerSizeFactor: 0.5,
        trainSizeFactor: 0.7,
        speedInCellsPerSecond: 3,
      ),
    ],
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
