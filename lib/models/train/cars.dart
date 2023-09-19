import 'dart:collection';
import 'dart:ui';

import 'package:bullet_train/models/foundation/foundation.dart';
import 'package:bullet_train/models/train/train.dart';

class Train {
  Train({required Cell startCell}) {
    final rail = startCell.toRail(Position.bottom, Position.top);
    _rails.addRail(rail);

    _bodies.add(TrainHead._(rail: rail, offset: rail.center));

    for (var i = 0; i < 8; i++) {
      addCar();
    }
  }

  final _bodies = LinkedList<TrainBody>();
  final _rails = Rails();

  Iterable<TrainBody> get bodies => _bodies;

  TrainHead get head => _bodies.first as TrainHead;
  Iterable<TrainCar> get cars => _bodies.whereType();

  void addCar() {
    _bodies.add(TrainCar(rail: _bodies.last.rail));
  }

  void moveNextTo(Position position) {
    head.rail.moveNextTo(position);
  }

  void moveForward(
    double dtPixels, {
    required void Function(TrainCar car) onNewDisplayedCar,
  }) {
    var currentRail = head.rail;
    var newOffset = head.offset;
    var pixels = dtPixels;

    do {
      (newOffset, pixels) = currentRail.moveForward(newOffset, pixels);

      if (pixels > 0) {
        currentRail = currentRail.nextOrCreate();
      }
    } while (pixels > 0);

    head
      ..rail = currentRail
      ..offset = newOffset;

    for (final car in cars) {
      if (!car.isActive && car.rail == currentRail) break;

      pixels = currentRail.cell.rect.width; // TODO(manu): with train car size

      do {
        (newOffset, pixels) = currentRail.rewind(newOffset, pixels);
        if (pixels > 0) {
          final previousRail = currentRail.previous;
          if (previousRail == null) break;

          currentRail = previousRail;
        }
      } while (pixels > 0);

      final callOnNewDisplayedCar = !car.isActive;

      car
        ..rail = currentRail
        ..offset = newOffset;

      if (callOnNewDisplayedCar) {
        onNewDisplayedCar(car);
      }
    }
  }

  void onGameResize(double scale) {
    for (final car in _bodies) {
      final carOffset = car.offset;

      if (carOffset != null) {
        car.offset = carOffset.scale(scale, scale);
      }
    }
  }
}

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
  TrainHead._({required super.rail, required super.offset});

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
