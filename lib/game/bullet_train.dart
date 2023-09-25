import 'package:audioplayers/audioplayers.dart';
import 'package:bullet_train/game/game.dart';
import 'package:bullet_train/models/models.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class BulletTrain extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  BulletTrain({
    required this.effectPlayer,
    GameTheme? theme,
    this.onGameOver,
  }) : theme = theme ?? GameTheme.defaultGameTheme;

  final AudioPlayer effectPlayer;
  final GameTheme theme;
  final VoidCallback? onGameOver;

  late World world;

  var _gameOver = false;
  final _paused = false;

  @override
  Color backgroundColor() => theme.backgroundColor;

  @override
  Future<void> onLoad() async {
    world = World(gridSize: theme.gridSize);

    await addAll([
      GameBackgroundComponent(),
      TrainComponent(trainBody: world.train.head),
      ScreenHitbox(),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_gameOver || _paused) return;

    final trainCarsToRemove = children
        .whereType<TrainComponent>()
        .where((tc) => !world.train.bodies.any((b) => b == tc.trainBody));

    for (final car in trainCarsToRemove) {
      car.removeFromParent();
    }

    final dtPixels = theme.speedInCellsPerSecond * dt;

    world
      ..moveForward(
        dtPixels,
        onNewDisplayedCar: (car) {
          add(TrainComponent(trainBody: car));
        },
      )
      ..addPassengerIfNeeded(
        trainSize: world.train.bodies.length,
        onPassengerAdded: (passenger) {
          add(PassengerComponent(passenger: passenger));
        },
      );
  }

  void over() {
    _gameOver = true;
    onGameOver?.call();
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      world.moveNextTo(Position.top);
      return KeyEventResult.handled;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      world.moveNextTo(Position.bottom);
      return KeyEventResult.handled;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      world.moveNextTo(Position.left);
      return KeyEventResult.handled;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      world.moveNextTo(Position.right);
      return KeyEventResult.handled;
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
