import 'dart:ui';

import 'package:bullet_train/engine/foundation/foundation.dart';

enum TravellerType {
  vilain,
  hero,
}

typedef Travellers = List<Traveller>;

class Traveller {
  Traveller({required this.type, required this.cell});

  final TravellerType type;
  final Cell cell;

  Offset get offset => cell.rect.center;

  double get radius => switch (type) {
        TravellerType.vilain => 2,
        TravellerType.hero => 1,
      };
}
