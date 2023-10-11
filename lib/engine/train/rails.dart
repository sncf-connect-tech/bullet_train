import 'dart:collection';
import 'dart:math' as math;

import 'package:bullet_train/engine/engine.dart';
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
    required Direction from,
    required Direction to,
  })  : _from = from,
        _to = to;

  final Cell cell;
  final Direction _from;
  Direction _to;

  Direction get from => _from;

  Direction get to => _to;

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

  void moveNextTo(Direction direction) {
    final nextRail = nextOrCreate();
    if (nextRail.from != direction) {
      nextRail._to = direction;
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
      case Direction.top:
        result = cell.up;
      case Direction.bottom:
        result = cell.down;
      case Direction.left:
        result = cell.left;
      case Direction.right:
        result = cell.right;
    }
    return result;
  }

  Cell get previousCell {
    Cell? result;

    switch (_from) {
      case Direction.top:
        result = cell.up;
      case Direction.bottom:
        result = cell.down;
      case Direction.left:
        result = cell.left;
      case Direction.right:
        result = cell.right;
    }
    return result;
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
      case Direction.top:
        switch (to) {
          case Direction.bottom:
            return linearForward(offset, pixels, to, rect);
          case Direction.left:
            return circleForward(
              offset,
              pixels,
              CircularDirection.topLeft,
              rect,
            );
          case Direction.right:
            return circleForward(
              offset,
              pixels,
              CircularDirection.topRight,
              rect,
            );
          case Direction.top:
        }
      case Direction.bottom:
        switch (to) {
          case Direction.top:
            return linearForward(offset, -pixels, to, rect);
          case Direction.left:
            return circleForward(
              offset,
              pixels,
              CircularDirection.bottomLeft,
              rect,
            );
          case Direction.right:
            return circleForward(
              offset,
              pixels,
              CircularDirection.bottomRight,
              rect,
            );
          case Direction.bottom:
        }
      case Direction.left:
        switch (to) {
          case Direction.top:
            return circleForward(
              offset,
              pixels,
              CircularDirection.leftTop,
              rect,
            );
          case Direction.bottom:
            return circleForward(
              offset,
              pixels,
              CircularDirection.leftBottom,
              rect,
            );
          case Direction.right:
            return linearForward(offset, pixels, to, rect);
          case Direction.left:
        }
      case Direction.right:
        switch (to) {
          case Direction.top:
            return circleForward(
              offset,
              pixels,
              CircularDirection.rightTop,
              rect,
            );
          case Direction.bottom:
            return circleForward(
              offset,
              pixels,
              CircularDirection.rightBottom,
              rect,
            );
          case Direction.left:
            return linearForward(offset, -pixels, to, rect);
          case Direction.right:
        }
    }

    throw BadDirectionError();
  }
}

class BadDirectionError extends UnsupportedError {
  BadDirectionError() : super('Bad direction');
}

enum RailMoveDirection { backward, forward }

extension ToRailsExtensions on Cell {
  Rail toRail(Direction from, Direction to) => Rail(
        cell: this,
        from: from,
        to: to,
      );
}
