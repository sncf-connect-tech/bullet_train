import 'dart:async';

import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:flame/components.dart';

class TravelersComponent extends Component with HasGameRef<BulletTrainGame> {
  TravelersComponent() : super(priority: GameLayer.traveler.priority);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addTravelersIfPossible();
  }

  void addTravelersIfPossible() {}
}
