import 'package:bullet_train/design/colors.dart';
import 'package:bullet_train/design/game_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String defaultPolice = 'Avenir';

class AppTheme {
  static final _baseTheme = ThemeData.dark();

  static final ThemeData themeData = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: ConnectColors.background,
      elevation: 0,
    ),
    fontFamily: defaultPolice,
    primaryColor: ConnectColors.primary,
    primaryColorDark: ConnectColors.primaryDark,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ConnectColors.primary),
        foregroundColor: MaterialStateProperty.all(ConnectColors.background),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 30)),
      ),
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
    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(color: ConnectColors.textPrimary),
    ),
    extensions: [
      GameTheme(
        backgroundColor: ConnectColors.background,
        snakeHeadColor: ConnectColors.primaryDark,
        snakeBodyColor: ConnectColors.primary,
        travelerHeroColor: ConnectColors.success,
        travelerVillainColor: ConnectColors.error,
        wallsColor: ConnectColors.surface,
        cellOddColor: ConnectColors.surface,
        cellEvenColor: ConnectColors.popup,
        gridSize: (width: 11, height: 11),
        travelerSizeFactor: 0.5,
        trainSizeFactor: 0.7,
        speedInCellsPerSecond: 3,
        initialNumberOfCars: 0,
      ),
    ],
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      titleMedium: const TextStyle(
        color: ConnectColors.textPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 60,
      ),
      titleLarge: const TextStyle(
        color: ConnectColors.error,
        fontWeight: FontWeight.w900,
        fontSize: 80,
      ),
      displayLarge: const TextStyle(
        color: ConnectColors.primaryDark,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
    ),
  );
}
