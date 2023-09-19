import 'package:audioplayers/audioplayers.dart';
import 'package:bullet_train/game/game.dart';
import 'package:bullet_train/l10n/l10n.dart';
import 'package:bullet_train/loading/loading.dart';
import 'package:flame/cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PreloadCubit(
            Images(prefix: ''),
            AudioCache(prefix: ''),
          )..loadSequentially(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSwatch();
    final theme = ThemeData(
      primaryColor: colorScheme.primary,
      colorScheme: colorScheme,
      extensions: [
        GameTheme(
          background: colorScheme.background,
          snakeHead: Colors.blue[900]!,
          snakeBody: colorScheme.primary,
          walls: Colors.red,
          gridOdd: Colors.green,
          gridEvent: Colors.lightGreen,
          gridSize: 17,
          speedInCellsPerSecond: 1.5,
        ),
      ],
      textTheme: GoogleFonts.poppinsTextTheme(),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LoadingPage(),
    );
  }
}
