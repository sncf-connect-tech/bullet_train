import 'dart:ui';

import 'package:bullet_train/engine/foundation/foundation.dart';

enum PassengerType {
  vilain,
  hero,
}

typedef Passengers = List<Passenger>;

class Passenger {
  Passenger({required this.type, required this.cell});

  final PassengerType type;
  final Cell cell;

  Offset get offset => cell.rect.center;

  double get radius => switch (type) {
        PassengerType.vilain => 2,
        PassengerType.hero => 1,
      };
}
