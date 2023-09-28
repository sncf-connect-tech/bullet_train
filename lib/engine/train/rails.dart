import 'dart:collection';
import 'dart:math' as math;

import 'package:bullet_train/engine/foundation/computation.dart';
import 'package:bullet_train/engine/foundation/foundation.dart';
import 'package:flutter/painting.dart';

class Rails {
  Rails();

  final _rails = LinkedList<Rail>();

  Iterable<Rail> get rails => _rails;

  void addRail(Rail rail) => _rails.add(rail);
  void remove() => _rails.remove(_rails.first);
}

final class Rail extends LinkedListEntry<Rail> {
  Rail({
    required this.cell,
    required Position from,
    required Position to,
  })  : _from = from,
        _to = to;

  final Cell cell;
  final Position _from;
  Position _to;

  Position get from => _from;
  Position get to => _to;

  Offset get center => cell.rect.center;

  (Offset offset, double pixels, double angle) moveForward(
    Offset offset,
    double pixels,
  ) =>
      _move(offset, pixels, RailMoveDirection.forward);

  (Offset offset, double pixels, double angle) rewind(
    Offset offset,
    double pixels,
  ) {
    final result = _move(offset, pixels, RailMoveDirection.backward);

    return (result.$1, result.$2, result.$3 + math.pi);
  }

  void moveNextTo(Position position) {
    final nextRail = nextOrCreate();
    if (nextRail.from != position) {
      nextRail._to = position;
    }
  }

  Rail nextOrCreate() {
    var result = next;

    if (result != null) return result;

    result = Rail(
      cell: _nextCell,
      from: to.opposite,
      to: to,
    );

    insertAfter(result);

    return result;
  }

  Cell get _nextCell {
    Cell? result;

    switch (_to) {
      case Position.top:
        result = cell.up;
      case Position.bottom:
        result = cell.down;
      case Position.left:
        result = cell.left;
      case Position.right:
        result = cell.right;
      case Position.unknown:
    }

    if (result != null) {
      return result;
    }

    throw BadDirectionError();
  }

  Cell get previousCell {
    Cell? result;

    switch (_from) {
      case Position.top:
        result = cell.up;
      case Position.bottom:
        result = cell.down;
      case Position.left:
        result = cell.left;
      case Position.right:
        result = cell.right;
      case Position.unknown:
    }

    if (result != null) {
      return result;
    }

    throw BadDirectionError();
  }

  (Offset offset, double pixels, double angle) _move(
    Offset offset,
    double pixels,
    RailMoveDirection direction,
  ) {
    if (pixels == 0) return (offset, 0, 0);

    final rect = cell.rect;
    final (from, to) = switch (direction) {
      RailMoveDirection.backward => (_to, _from),
      RailMoveDirection.forward => (_from, _to)
    };

    switch (from) {
      case Position.top:
        switch (to) {
          case Position.bottom:
            return linearForward(offset, pixels, Direction.vertical, rect);
          case Position.left:
            return circleForward(
              offset,
              pixels,
              CircularDirection.topLeft,
              rect,
            );
          case Position.right:
            return circleForward(
              offset,
              pixels,
              CircularDirection.topRight,
              rect,
            );
          case Position.top:
          case Position.unknown:
        }
      case Position.bottom:
        switch (to) {
          case Position.top:
            return linearForward(offset, -pixels, Direction.vertical, rect);
          case Position.left:
            return circleForward(
              offset,
              pixels,
              CircularDirection.bottomLeft,
              rect,
            );
          case Position.right:
            return circleForward(
              offset,
              pixels,
              CircularDirection.bottomRight,
              rect,
            );
          case Position.bottom:
          case Position.unknown:
        }
      case Position.left:
        switch (to) {
          case Position.top:
            return circleForward(
              offset,
              pixels,
              CircularDirection.leftTop,
              rect,
            );
          case Position.bottom:
            return circleForward(
              offset,
              pixels,
              CircularDirection.leftBottom,
              rect,
            );
          case Position.right:
            return linearForward(offset, pixels, Direction.horizontal, rect);
          case Position.left:
          case Position.unknown:
        }
      case Position.right:
        switch (to) {
          case Position.top:
            return circleForward(
              offset,
              pixels,
              CircularDirection.rightTop,
              rect,
            );
          case Position.bottom:
            return circleForward(
              offset,
              pixels,
              CircularDirection.rightBottom,
              rect,
            );
          case Position.left:
            return linearForward(offset, -pixels, Direction.horizontal, rect);
          case Position.right:
          case Position.unknown:
        }
      case Position.unknown:
    }

    throw BadDirectionError();
  }
}

class BadDirectionError extends UnsupportedError {
  BadDirectionError() : super('Bad direction');
}

enum RailMoveDirection { backward, forward }

extension ToRailsExtensions on Cell {
  Rail toRail(Position from, Position to) => Rail(
        cell: this,
        from: from,
        to: to,
      );
}
