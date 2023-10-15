import 'package:bullet_train/design/theme/game_theme.dart';
import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/component/background_component.dart';
import 'package:bullet_train/game/component/train_component.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class BulletTrainGame extends FlameGame with HasKeyboardHandlerComponents {
  BulletTrainGame({required this.theme});

  final GameTheme theme;
  late final CellsMatrix matrix;
  late TrainComponent trainComponent;

  final World _world = World();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    matrix = CellsMatrix(gridSize: theme.gridSize);
    trainComponent = TrainComponent();

    await _world.addAll([
      BackgroundComponent(),
      trainComponent,
    ]);

    final camera = CameraComponent(
      viewfinder: Viewfinder()
        ..anchor = Anchor.topLeft
        ..visibleGameSize = theme.gridSize.toVector2(),
      world: _world,
    );

    await addAll([_world, camera]);
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
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
