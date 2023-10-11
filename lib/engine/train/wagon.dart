import 'dart:ui';

import 'package:bullet_train/engine/train/rails.dart';

sealed class Wagon {
  Wagon({
    required this.rail,
    required this.offset,
    required this.angle,
  });

  Rail rail;
  Offset? offset;
  double? angle;

  bool get isActive => offset != null;
}

final class HeadWagon extends Wagon {
  HeadWagon({required super.rail, required super.offset, required super.angle});

  @override
  Offset get offset => super.offset!;
}

final class BodyWagon extends Wagon {
  BodyWagon({required super.rail}) : super(offset: null, angle: null);
}
