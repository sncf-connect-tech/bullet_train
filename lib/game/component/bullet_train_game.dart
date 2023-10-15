import 'package:bullet_train/design/theme/game_theme.dart';
import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/component/background_component.dart';
import 'package:bullet_train/game/component/train_component.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class BulletTrainGame extends FlameGame {
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
}
