import 'dart:collection';
import 'dart:ui';

import 'package:bullet_train/models/foundation/foundation.dart';
import 'package:bullet_train/models/train/train.dart';

class Train {
  Train({required Cell startCell}) {
    final rail = startCell.toRail(Position.bottom, Position.top);

    _rails.addRail(rail);
    _bodies.add(TrainHead(rail: rail, offset: rail.center));

    for (var i = 0; i < 4; i++) {
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

  void removeCar() {
    _bodies.remove(_bodies.last);
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

        newOffset = _computeOffsetFromPosition(
          currentRail,
          RailMoveDirection.forward,
        );
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

          newOffset = _computeOffsetFromPosition(
            currentRail,
            RailMoveDirection.backward,
          );
        }
      } while (pixels > 0);

      final lastRail = cars.last.rail.previous;

      if (lastRail != null) lastRail.list!.remove(lastRail);

      final callOnNewDisplayedCar = !car.isActive;

      car
        ..rail = currentRail
        ..offset = newOffset;

      if (callOnNewDisplayedCar) {
        onNewDisplayedCar(car);
      }
    }
  }

  Offset _computeOffsetFromPosition(
    Rail currentRail,
    RailMoveDirection moveDirection,
  ) {
    final position = switch (moveDirection) {
      RailMoveDirection.forward => currentRail.from,
      RailMoveDirection.backward => currentRail.to,
    };

    return switch (position) {
      Position.top => currentRail.cell.rect.topCenter,
      Position.bottom => currentRail.cell.rect.bottomCenter,
      Position.left => currentRail.cell.rect.centerLeft,
      Position.right => currentRail.cell.rect.centerRight,
      Position.unknown => currentRail.cell.rect.center,
    };
  }
}
