import 'dart:math' as math;
import 'dart:ui';

import 'package:bullet_train/engine/engine.dart';

(Offset offset, double pixels, double angle) linearForward(
  Offset offset,
  double pixels,
  Direction direction,
  Rect rect,
) {
  late double overflowPixels;
  late Offset newOffset;
  late double angle;

  switch (direction) {
    case Direction.horizontal:
      if (pixels > 0) {
        newOffset = Offset(
          (offset.dx + pixels).clamp(rect.left, rect.right),
          offset.dy,
        );
        overflowPixels =
            (offset.dx + pixels - rect.right).clamp(0, double.infinity);
        angle = 0;
      } else {
        newOffset = Offset(
          (offset.dx + pixels).clamp(rect.left, rect.right),
          offset.dy,
        );
        overflowPixels =
            (rect.left - (offset.dx + pixels)).clamp(0, double.infinity);
        angle = math.pi;
      }
      return (
        newOffset,
        overflowPixels,
        angle,
      );
    case Direction.vertical:
      if (pixels > 0) {
        newOffset = Offset(
          offset.dx,
          (offset.dy + pixels).clamp(rect.top, rect.bottom),
        );
        overflowPixels =
            (offset.dy + pixels - rect.bottom).clamp(0, double.infinity);
        angle = math.pi / 2;
      } else {
        newOffset = Offset(
          offset.dx,
          (offset.dy + pixels).clamp(rect.top, rect.bottom),
        );
        overflowPixels =
            (rect.top - (offset.dy + pixels)).clamp(0, double.infinity);
        angle = -math.pi / 2;
      }

      return (newOffset, overflowPixels, angle);
  }
}

(Offset offset, double pixels, double angle) circleForward(
  Offset offset,
  double pixels,
  CircularDirection direction,
  Rect rect,
) {
  const rad = math.pi / 2;
  final radius = rect.width / 2;

  final pixelsInRad = (pixels / radius) * rad;

  (double, double) computeNewAngle(
    Offset offset, {
    required bool complementAngle,
  }) {
    var currentAngle = math.acos((offset.dx / radius).clamp(0, 1));
    if (complementAngle) {
      currentAngle = rad - currentAngle;
    }

    final overflowPixels =
        ((currentAngle + pixelsInRad - rad) / rad).clamp(0, double.infinity) *
            radius;

    if (overflowPixels > 0) {
      return (0, overflowPixels);
    }
    var result = currentAngle + pixelsInRad;

    if (complementAngle) {
      result = rad - result;
    }

    return (result, 0);
  }

  switch (direction) {
    case CircularDirection.leftTop:
      final localOffset = Offset(offset.dx - rect.left, offset.dy - rect.top);
      final (newAngle, overflowPixels) =
          computeNewAngle(localOffset, complementAngle: true);

      if (overflowPixels > 0) {
        return (
          rect.topCenter,
          overflowPixels,
          math.pi / 2,
        );
      }

      return (
        rect.topLeft.translate(
          math.cos(newAngle) * radius,
          math.sin(newAngle) * radius,
        ),
        0,
        -math.pi / 2 + newAngle,
      );

    case CircularDirection.leftBottom:
      final localOffset =
          Offset(offset.dx - rect.left, rect.bottom - offset.dy);
      final (newAngle, overflowPixels) =
          computeNewAngle(localOffset, complementAngle: true);

      if (overflowPixels > 0) {
        return (
          rect.bottomCenter,
          overflowPixels,
          -math.pi / 2,
        );
      }

      return (
        rect.bottomLeft.translate(
          math.cos(newAngle) * radius,
          -math.sin(newAngle) * radius,
        ),
        0,
        math.pi / 2 - newAngle,
      );

    case CircularDirection.topLeft:
      final localOffset = Offset(offset.dx - rect.left, offset.dy - rect.top);
      final (newAngle, overflowPixels) =
          computeNewAngle(localOffset, complementAngle: false);

      if (overflowPixels > 0) {
        return (
          rect.centerLeft,
          overflowPixels,
          math.pi,
        );
      }

      return (
        rect.topLeft.translate(
          math.cos(newAngle) * radius,
          math.sin(newAngle) * radius,
        ),
        0,
        math.pi / 2 + newAngle,
      );

    case CircularDirection.topRight:
      final localOffset = Offset(rect.right - offset.dx, offset.dy - rect.top);
      final (newAngle, overflowPixels) =
          computeNewAngle(localOffset, complementAngle: false);

      if (overflowPixels > 0) {
        return (
          rect.centerRight,
          overflowPixels,
          0,
        );
      }

      return (
        rect.topRight.translate(
          -math.cos(newAngle) * radius,
          math.sin(newAngle) * radius,
        ),
        0,
        math.pi / 2 - newAngle,
      );

    case CircularDirection.rightTop:
      final localOffset = Offset(rect.right - offset.dx, offset.dy - rect.top);
      final (newAngle, overflowPixels) =
          computeNewAngle(localOffset, complementAngle: true);

      if (overflowPixels > 0) {
        return (
          rect.topCenter,
          overflowPixels,
          math.pi / 2,
        );
      }

      return (
        rect.topRight.translate(
          -math.cos(newAngle) * radius,
          math.sin(newAngle) * radius,
        ),
        0,
        -math.pi / 2 - newAngle,
      );

    case CircularDirection.rightBottom:
      final localOffset =
          Offset(rect.right - offset.dx, rect.bottom - offset.dy);
      final (newAngle, overflowPixels) =
          computeNewAngle(localOffset, complementAngle: true);

      if (overflowPixels > 0) {
        return (
          rect.bottomCenter,
          overflowPixels,
          -math.pi / 2,
        );
      }

      return (
        rect.bottomRight.translate(
          -math.cos(newAngle) * radius,
          -math.sin(newAngle) * radius,
        ),
        0,
        math.pi / 2 + newAngle,
      );

    case CircularDirection.bottomLeft:
      final localOffset =
          Offset(offset.dx - rect.left, rect.bottom - offset.dy);
      final (newAngle, overflowPixels) =
          computeNewAngle(localOffset, complementAngle: false);

      if (overflowPixels > 0) {
        return (
          rect.centerLeft,
          overflowPixels,
          math.pi,
        );
      }

      return (
        rect.bottomLeft.translate(
          math.cos(newAngle) * radius,
          -math.sin(newAngle) * radius,
        ),
        0,
        -math.pi / 2 - newAngle,
      );

    case CircularDirection.bottomRight:
      final localOffset =
          Offset(rect.right - offset.dx, rect.bottom - offset.dy);
      final (newAngle, overflowPixels) =
          computeNewAngle(localOffset, complementAngle: false);

      if (overflowPixels > 0) {
        return (
          rect.centerRight,
          overflowPixels,
          0,
        );
      }

      return (
        rect.bottomRight.translate(
          -math.cos(newAngle) * radius,
          -math.sin(newAngle) * radius,
        ),
        0,
        -math.pi / 2 + newAngle,
      );
  }
}
