import 'dart:collection';
import 'dart:ui';

import 'package:bullet_train/engine/train/train.dart';

sealed class TrainBody extends LinkedListEntry<TrainBody> {
  TrainBody({
    required this.rail,
    required this.offset,
    required this.angle,
  });

  Rail rail;
  Offset? offset;
  double? angle;

  bool get isHead;

  bool get isActive => offset != null;
}

base class TrainHead extends TrainBody {
  TrainHead({required super.rail, required super.offset, required super.angle});

  @override
  Offset get offset => super.offset!;

  @override
  bool get isHead => true;
}

base class TrainCar extends TrainBody {
  TrainCar({required super.rail}) : super(offset: null, angle: null);

  @override
  bool get isHead => false;
}
