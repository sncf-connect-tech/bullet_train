import 'package:bullet_train/design/theme/game_theme.dart';
import 'package:bullet_train/engine/engine.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class BulletTrainGame extends FlameGame {
  BulletTrainGame({required this.theme});

  final GameTheme theme;

  final World _world = World();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final camera = CameraComponent(
      viewfinder: Viewfinder()
        ..anchor = Anchor.topLeft
        ..visibleGameSize = theme.gridSize.toVector2(),
      world: _world,
    );

    await addAll([_world, camera]);
  }
}
