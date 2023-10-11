import 'dart:math';

import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

class ScoreManager extends Component with HasGameRef<BulletTrainGame> {
  ScoreManager();

  ValueNotifier<int> score = ValueNotifier(0);
  ValueNotifier<int> bestScore = ValueNotifier(0);

  void reset() {
    score.value = 0;
  }

  void increaseScore() {
    score.value++;
    bestScore.value = max(bestScore.value, score.value);
  }

  void decreaseScore() {
    if (score.value > 0) {
      score.value--;
    }
  }
}
