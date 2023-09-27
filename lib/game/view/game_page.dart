import 'package:bullet_train/cubit/cubit.dart';
import 'package:bullet_train/game/game.dart';
import 'package:bullet_train/shared/difficulty.dart';
import 'package:bullet_train/theme/theme.dart';
import 'package:flame/game.dart' hide Route;
import 'package:flame_audio/bgm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePage extends StatelessWidget {
  const GamePage({required this.difficulty, super.key});

  final Difficulty difficulty;

  static Route<void> route({ required Difficulty difficulty}) {
    return MaterialPageRoute<void>(
      builder: (_) => GamePage(difficulty: difficulty),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AudioCubit(audioCache: context.read<PreloadCubit>().audio);
      },
      child: Scaffold(
        body: SafeArea(
          child: GameView(
            difficulty: difficulty,
          ),
        ),
      ),
    );
  }
}

class GameView extends StatefulWidget {
  const GameView({required this.difficulty, this.game, super.key});

  final FlameGame? game;
  final Difficulty difficulty;

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  FlameGame? _game;
  bool _gameOver = false;

  late final Bgm bgm;

  @override
  void initState() {
    super.initState();
    bgm = context.read<AudioCubit>().bgm;
    // bgm.play(Assets.audio.background);
  }

  @override
  void dispose() {
    bgm.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameTheme =
        Theme.of(context).extension<GameTheme>() ?? GameTheme.defaultGameTheme;

    _game ??= widget.game ??
        BulletTrain(
          effectPlayer: context.read<AudioCubit>().effectPlayer,
          theme: gameTheme,
          difficulty: widget.difficulty,
          onGameOver: () {
            setState(() {
              _gameOver = true;
            });
          },
        );
    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: AspectRatio(
              aspectRatio: gameTheme.gridAspectRatio,
              child: GameWidget(game: _game!),
            ),
          ),
        ),
        Positioned(
          top: 30,
          left: 30,
          child: ScoreDisplay(game: _game!),
        ),
        Align(
          alignment: Alignment.topRight,
          child: BlocBuilder<AudioCubit, AudioState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.volume == 0 ? Icons.volume_off : Icons.volume_up,
                ),
                onPressed: () => context.read<AudioCubit>().toggleVolume(),
              );
            },
          ),
        ),
        Center(
          child: GameOver(
            isVisible: _gameOver,
            onPressContinue: () {
              setState(() {
                _gameOver = false;
              });

              _game = BulletTrain(
                effectPlayer: context.read<AudioCubit>().effectPlayer,
                theme: gameTheme,
                difficulty: widget.difficulty,
                onGameOver: () {
                  setState(() {
                    _gameOver = true;
                  });
                },
              );
            },
            onPressLeave: () {
              setState(() {
                _gameOver = false;
              });
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
