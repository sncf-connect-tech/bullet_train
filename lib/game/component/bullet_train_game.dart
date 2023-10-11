import 'package:bullet_train/design/theme/game_theme.dart';
import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/component/background_component.dart';
import 'package:bullet_train/game/component/train_component.dart';
import 'package:bullet_train/game/component/travelers_component.dart';
import 'package:bullet_train/game/manager/game_manager.dart';
import 'package:bullet_train/game/manager/score_manager.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class BulletTrainGame extends FlameGame with HasKeyboardHandlerComponents {
  BulletTrainGame({required this.theme});

  final GameTheme theme;
  late GameManager gameManager;
  late ScoreManager scoreManager;
  late final CellsMatrix matrix;
  late TrainComponent trainComponent;
  late TravelersComponent travelersComponent;

  void startGame() {
    overlays.remove('gameOverOverlay');
  }

  void gameOver() {
    gameManager.gameOver();
    overlays.add('gameOverOverlay');
  }

  void resetGame() {
    world.remove(trainComponent);
    trainComponent = TrainComponent();
    world.add(trainComponent);
    gameManager.reset();
    startGame();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    matrix = CellsMatrix(gridSize: theme.gridSize);
    gameManager = GameManager();
    trainComponent = TrainComponent();
    travelersComponent = TravelersComponent();

    await world.addAll([
      BackgroundComponent(),
      trainComponent,
      gameManager,
      travelersComponent,
    ]);

    final camera = CameraComponent(
      viewfinder: Viewfinder()
        ..anchor = Anchor.topLeft
        ..visibleGameSize = theme.gridSize.toVector2(),
      world: world,
    );

    await add(camera);
    startGame();
  }

  @override
  void update(double dt) {
    if (gameManager.isGameOver) return;
    super.update(dt);
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      trainComponent.moveTo(Direction.top);
      return KeyEventResult.handled;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      trainComponent.moveTo(Direction.bottom);
      return KeyEventResult.handled;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      trainComponent.moveTo(Direction.left);
      return KeyEventResult.handled;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      trainComponent.moveTo(Direction.right);
      return KeyEventResult.handled;
    } else if(keysPressed.contains(LogicalKeyboardKey.keyA)) {
      travelersComponent.addTravelersIfPossible();
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
