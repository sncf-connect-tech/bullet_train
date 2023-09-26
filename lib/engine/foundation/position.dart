enum Position {
  top,
  bottom,
  left,
  right,
  unknown;

  Position get opposite => switch (this) {
        Position.top => Position.bottom,
        Position.bottom => Position.top,
        Position.left => Position.right,
        Position.right => Position.left,
        Position.unknown => this,
      };
}

enum Direction {
  horizontal,
  vertical,
}

enum CircularDirection {
  leftTop,
  leftBottom,
  topLeft,
  topRight,
  rightTop,
  rightBottom,
  bottomLeft,
  bottomRight,
}
