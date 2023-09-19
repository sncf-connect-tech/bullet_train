import 'dart:collection';
import 'dart:ui';

import 'package:bullet_train/models/train/train.dart';

sealed class TrainBody extends LinkedListEntry<TrainBody> {
  TrainBody({
    required this.rail,
    required this.offset,
  });

  Rail rail;
  Offset? offset;

  bool get isHead;

  bool get isActive => offset != null;
}

base class TrainHead extends TrainBody {
  TrainHead({required super.rail, required super.offset});

  @override
  Offset get offset => super.offset!;

  @override
  bool get isHead => true;
}

base class TrainCar extends TrainBody {
  TrainCar({required super.rail}) : super(offset: null);

  @override
  bool get isHead => false;
}
