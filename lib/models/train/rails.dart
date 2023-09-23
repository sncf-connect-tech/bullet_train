import 'dart:collection';

import 'package:bullet_train/models/foundation/foundation.dart';
import 'package:bullet_train/services/services.dart';
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

  (Offset, double) moveForward(Offset offset, double pixels) =>
      _move(offset, pixels, _MoveDirection.forward);

  (Offset, double) rewind(Offset offset, double pixels) =>
      _move(offset, pixels, _MoveDirection.backward);

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

  (Offset, double) _move(
    Offset offset,
    double pixels,
    _MoveDirection direction,
  ) {
    if (pixels == 0) return (offset, 0);

    final rect = cell.rect;
    final (from, to) = switch (direction) {
      _MoveDirection.backward => (_to, _from),
      _MoveDirection.forward => (_from, _to)
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

enum _MoveDirection { backward, forward }

extension ToRailsExtensions on Cell {
  Rail toRail(Position from, Position to) => Rail(
        cell: this,
        from: from,
        to: to,
      );
}
