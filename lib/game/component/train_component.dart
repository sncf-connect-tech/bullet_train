import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;

import 'package:bullet_train/engine/engine.dart';
import 'package:bullet_train/game/component/bullet_train_game.dart';
import 'package:bullet_train/game/component/wagon_component.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class TrainComponent extends Component
    with HasGameRef<BulletTrainGame>, CollisionCallbacks {
  TrainComponent() : super(priority: GameLayer.train.priority);

  final _wagons = LinkedList<WagonComponent>();
  final _rails = Rails();

  Set<Cell> get trainCells => Set<Cell>.from(
        _wagons.map((body) => body.wagon.rail.cell),
      );

  HeadWagon get _head => _wagons.first.wagon as HeadWagon;

  Iterable<WagonComponent> get _bodies =>
      _wagons.where((wagon) => wagon.wagon is BodyWagon);

  /// Move train to [direction] in next cell.
  void moveTo(Direction direction) => _head.rail.moveNextTo(direction);

  /// Add wagon to train.
  Future<void> addWagon() async {
    final wagon = BodyWagon(rail: _wagons.last.wagon.rail);
    final wagonC = WagonComponent(wagon: wagon);
    if (_wagons.length > 1) {
      _wagons.last.insertBefore(wagonC);
    } else {
      _wagons.add(wagonC);
    }
  }

  Future<void> addHead() async {
    final startCell = gameRef.matrix.center();
    final rail = startCell.toRail(Direction.bottom, Direction.top);
    _rails.addRail(rail);
    final head = WagonComponent(
      wagon: HeadWagon(rail: rail, offset: rail.center, angle: math.pi / 2),
    );

    _wagons.add(head);
    await add(head);
  }

  /// Remove wagon from train.
  void removeWagon() {
    remove(_wagons.last);
    _wagons.remove(_wagons.last);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await addHead();
    const initialNumberOfCars = 2;
    for (var i = 0; i < initialNumberOfCars; i++) {
      await addWagon();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    _moveForward(3 * dt);
  }

  void _moveForward(double dtPixels) {
    var currentRail = _head.rail;
    var newOffset = _head.offset;
    var pixels = dtPixels;
    late double angle;

    do {
      (newOffset, pixels, angle) = currentRail.moveForward(newOffset, pixels);
      if (pixels > 0) {
        currentRail = currentRail.nextOrCreate();
        newOffset = computeOffsetFromDirection(
          currentRail,
          RailMoveDirection.forward,
        );
      }
    } while (pixels > 0);

    _head
      ..rail = currentRail
      ..offset = newOffset
      ..angle = angle;

    for (final body in _bodies) {
      if (!body.wagon.isActive && body.wagon.rail == currentRail) break;
      pixels = currentRail.cell.rect.longestSide;
      do {
        (newOffset, pixels, angle) = currentRail.rewind(newOffset, pixels);
        if (pixels > 0) {
          final previousRail = currentRail.previous;
          if (previousRail == null) break;
          currentRail = previousRail;
          newOffset = computeOffsetFromDirection(
            currentRail,
            RailMoveDirection.backward,
          );
        }
      } while (pixels > 0);

      final lastRail = _bodies.last.wagon.rail.previous;
      if (lastRail != null) lastRail.list!.remove(lastRail);

      final shouldAddWagonToWorld = !body.wagon.isActive;
      body.wagon
        ..rail = currentRail
        ..offset = newOffset
        ..angle = angle;

      if (shouldAddWagonToWorld) {
        add(body);
      }
    }
  }
}
