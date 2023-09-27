import 'package:audioplayers/audioplayers.dart';
import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/game.dart';
import 'package:bullet_train/shared/difficulty.dart';
import 'package:bullet_train/theme/theme.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class BulletTrain extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  BulletTrain({
    required this.effectPlayer,
    required this.difficulty,
    required this.onGameOver,
    GameTheme? theme,
  }) : theme = theme ?? GameTheme.defaultGameTheme;

  final AudioPlayer effectPlayer;
  final GameTheme theme;
  final Difficulty difficulty;
  final VoidCallback onGameOver;

  late World engineWorld;

  var _gameOver = false;
  final _paused = false;
  final ValueNotifier<int> score = ValueNotifier(0);

  @override
  Color backgroundColor() => theme.backgroundColor;

  @override
  Future<void> onLoad() async {
    score.value = theme.initialNumberOfCars;

    engineWorld = World(
      gridSize: theme.gridSize,
      initialNumberOfCars: theme.initialNumberOfCars,
      difficulty: difficulty,
      onScoreIncrease: increaseScore,
      onScoreDecrease: decreaseScore,
    );

    await addAll([
      GameBackgroundComponent(),
      TrainComponent(trainBody: engineWorld.train.head),
      ScreenHitbox(),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (engineWorld.train.bodies.isEmpty) {
      over();
    }

    if (_gameOver || _paused) return;

    final trainCarsToRemove = children
        .whereType<TrainComponent>()
        .where((tc) => !engineWorld.train.bodies.any((b) => b == tc.trainBody));

    for (final car in trainCarsToRemove) {
      car.removeFromParent();
    }

    final dtPixels = theme.speedInCellsPerSecond * dt;

    engineWorld
      ..moveForward(
        dtPixels,
        onNewDisplayedCar: (car) {
          add(TrainComponent(trainBody: car));
        },
      )
      ..addTravelerIfNeeded(
        onTravelerAdded: (traveler) {
          add(TravelerComponent(traveler: traveler));
        },
      );
  }

  void over() {
    _gameOver = true;
    onGameOver();
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      engineWorld.moveNextTo(Position.top);
      return KeyEventResult.handled;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      engineWorld.moveNextTo(Position.bottom);
      return KeyEventResult.handled;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      engineWorld.moveNextTo(Position.left);
      return KeyEventResult.handled;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      engineWorld.moveNextTo(Position.right);
      return KeyEventResult.handled;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  void increaseScore() {
    score.value++;
  }

  void decreaseScore() {
    score.value--;
  }
}
