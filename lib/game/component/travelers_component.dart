import 'dart:async';

import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:bullet_train/game/component/traveler_component.dart';
import 'package:flame/components.dart';

class TravelersComponent extends Component with HasGameRef<BulletTrainGame> {
  TravelersComponent() : super(priority: GameLayer.traveler.priority);

  final _travelers = <Traveler>[];

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addTravelersIfPossible();
  }

  void removeTraveler(Traveler traveler) => _travelers.remove(traveler);

  void _addTraveler(Traveler traveler) {
    _travelers.add(traveler);
    add(TravelerComponent(traveler: traveler));
  }

  void addTravelersIfPossible() {
    if (!_travelers.any((p) => p.type == TravelerType.hero)) {
      // Check free space
      final train = gameRef.trainComponent;
      final travelersCells = Set<Cell>.from(_travelers.map((p) => p.cell));
      final availableOffsets = gameRef.matrix.allOffsets
          .difference(travelersCells)
          .difference(train.trainCells);
      if (availableOffsets.isEmpty) return;

      // Hero
      final heroCell = gameRef.matrix.randomFrom(availableOffsets);
      final hero = Traveler(type: TravelerType.hero, cell: heroCell);
      _addTraveler(hero);
      availableOffsets.remove(heroCell);
      if (availableOffsets.isEmpty) return;

      // Vilains
      final vilainCell = gameRef.matrix.randomFrom(availableOffsets);
      final vilain = Traveler(type: TravelerType.vilain, cell: vilainCell);
      availableOffsets.remove(vilainCell);
      _addTraveler(vilain);
      if (availableOffsets.isEmpty) return;
    }
  }
}
