import 'package:bullet_train/design/theme/game_theme.dart';
import 'package:bullet_train/engine/engine.dart';
// ignore: unused_import
import 'package:bullet_train/game/component/background_component.dart';
import 'package:bullet_train/game/manager/score_manager.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class BulletTrainGame extends FlameGame {
  BulletTrainGame({required this.theme});

  final GameTheme theme;
  late ScoreManager scoreManager;
  late final CellsMatrix matrix;

  void resetGame() {}

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    matrix = CellsMatrix(gridSize: theme.gridSize);

    // TODO: add background component

    final camera = CameraComponent(
      viewfinder: Viewfinder()
        ..anchor = Anchor.topLeft
        ..visibleGameSize = theme.gridSize.toVector2(),
      world: world,
    );

    await add(camera);
  }
}
