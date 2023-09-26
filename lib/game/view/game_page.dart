import 'package:bullet_train/game/components/game_over.dart';
import 'package:bullet_train/game/game.dart';
import 'package:bullet_train/loading/cubit/cubit.dart';
import 'package:flame/game.dart' hide Route;
import 'package:flame_audio/bgm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const GamePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AudioCubit(audioCache: context.read<PreloadCubit>().audio);
      },
      child: const Scaffold(
        body: SafeArea(child: GameView()),
      ),
    );
  }
}

class GameView extends StatefulWidget {
  const GameView({super.key, this.game});

  final FlameGame? game;

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
          onGameOver: () {
            setState(() {
              _gameOver = true;
            });
          }
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
        AnimatedOpacity(
          opacity: _gameOver ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: Visibility(
            visible: _gameOver,
            child: Center(
              child: GameOver(
                onPressContinue: () {
                  setState(() {
                    _gameOver = false;
                  });
                  // TODO: peut-être un truc plus efficient qu'un pop and push
                  Navigator.of(context).pop();
                  Navigator.of(context).push(GamePage.route());
                },
                onPressLeave: () {
                  setState(() {
                    _gameOver = false;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
