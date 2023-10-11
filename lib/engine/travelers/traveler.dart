import 'dart:ui';

import 'package:bullet_train/engine/foundation/cells.dart';

enum TravelerType {
  vilain,
  hero,
}

class Traveler {
  Traveler({required this.type, required this.cell});

  final TravelerType type;
  final Cell cell;

  Offset get offset => cell.rect.center;
}
