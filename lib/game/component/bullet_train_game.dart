import 'package:bullet_train/design/theme/game_theme.dart';
import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/component/background_component.dart';
import 'package:bullet_train/game/component/train_component.dart';
import 'package:bullet_train/game/manager/score_manager.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/src/services/raw_keyboard.dart';
import 'package:flutter/src/widgets/focus_manager.dart';

class BulletTrainGame extends FlameGame with HasKeyboardHandlerComponents {
  BulletTrainGame({required this.theme});

  final GameTheme theme;
  late ScoreManager scoreManager;
  late final CellsMatrix matrix;
  late TrainComponent trainComponent;

  void resetGame() {}

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    matrix = CellsMatrix(gridSize: theme.gridSize);
    trainComponent = TrainComponent();

    await world.addAll([
      BackgroundComponent(),
      trainComponent,
    ]);

    final camera = CameraComponent(
      viewfinder: Viewfinder()
        ..anchor = Anchor.topLeft
        ..visibleGameSize = theme.gridSize.toVector2(),
      world: world,
    );

    await add(camera);
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event, 
    Set<LogicalKeyboardKey> keysPressed
  ) {
    // TODO: implémenter les directions
    return super.onKeyEvent(event, keysPressed);
  }
}
