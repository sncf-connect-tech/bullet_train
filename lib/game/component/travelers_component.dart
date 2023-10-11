import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:flame/components.dart';

class TravelersComponent extends Component with HasGameRef<BulletTrainGame> {
  TravelersComponent() : super(priority: GameLayer.traveler.priority);

  void addTravelersIfPossible() {
    print('addTravelersIfPossible');
    // TODO add vilain on the map
    // TODO add hero on the map
    // TODO randomize where they pop
    // TODO don't add travelers on top of each other
    // TODO don't add travelers on top of the train
  }
}
