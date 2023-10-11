import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:flame/components.dart';

enum GameState { playing, gameOver }

class GameManager extends Component with HasGameRef<BulletTrainGame> {
  GameManager();

  GameState state = GameState.playing;

  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;

  void gameOver() {
    state = GameState.gameOver;
  }

  void reset() {
    state = GameState.playing;
  }
}
