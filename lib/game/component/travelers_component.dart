import 'dart:async';

import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:bullet_train/game/component/traveler_component.dart';
import 'package:flame/components.dart';

class TravelersComponent extends Component with HasGameRef<BulletTrainGame> {
  TravelersComponent() : super(priority: GameLayer.traveler.priority);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addTravelersIfPossible();
  }

  void addTravelersIfPossible() {
    final travelers = children
        .whereType<TravelerComponent>()
        .where((traveler) => !traveler.isRemoving)
        .toList();

    if (!travelers.any((p) => p.type == TravelerType.hero)) {
      // Check free space
      final train = gameRef.trainComponent;
      final travelersCells = Set<Cell>.from(travelers.map((p) => p.cell));
      final availableOffsets = gameRef.matrix.allOffsets
          .difference(travelersCells)
          .difference(train.trainCells);
      if (availableOffsets.isEmpty) return;

      // Hero
      final heroCell = gameRef.matrix.randomFrom(availableOffsets);
      final hero = TravelerComponent(type: TravelerType.hero, cell: heroCell);
      add(hero);
      availableOffsets.remove(heroCell);
      if (availableOffsets.isEmpty) return;

      // Vilains
      final vilainCell = gameRef.matrix.randomFrom(availableOffsets);
      final vilain =
          TravelerComponent(type: TravelerType.vilain, cell: vilainCell);
      availableOffsets.remove(vilainCell);
      add(vilain);
      if (availableOffsets.isEmpty) return;
    }
  }
}
