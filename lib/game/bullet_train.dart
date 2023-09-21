import 'package:audioplayers/audioplayers.dart';
import 'package:bullet_train/game/game.dart';
import 'package:bullet_train/l10n/l10n.dart';
import 'package:bullet_train/models/models.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ignore: deprecated_member_use
class BulletTrain extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  BulletTrain({
    required this.l10n,
    required this.effectPlayer,
    required this.theme,
  });

  final AppLocalizations l10n;
  final AudioPlayer effectPlayer;
  final GameTheme theme;
  late final World world;

  var _gameOver = false;

  @override
  Color backgroundColor() => theme.background;

  @override
  Future<void> onLoad() async {
    assert(size.x == size.y, 'Screen must be square for grid');
    world = World(gridSize: theme.gridSize, screenSize: size.x);

    await addAll([
      GameBackgroundComponent(),
      TrainComponent(trainBody: world.train.head),
      ScreenHitbox(),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_gameOver) return;

    final speedInCellsPerSecond = theme.speedInCellsPerSecond;
    final cellSize = size.x / theme.gridSize;
    final dtPixels = speedInCellsPerSecond * cellSize * dt;

    world.moveForward(
      dtPixels,
      onNewDisplayedCar: (car) {
        add(TrainComponent(trainBody: car));
      },
    );
  }

  void over() {
    _gameOver = true;
    print('Game over !');
  }

  @override
  void onGameResize(Vector2 size) {
    if (isLoaded) {
      world.onGameResize(size.x / this.size.x);
    }

    super.onGameResize(size);
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
