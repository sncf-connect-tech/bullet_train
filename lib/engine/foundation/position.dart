enum Direction {
  top,
  bottom,
  left,
  right;

  Direction get opposite => switch (this) {
        Direction.top => Direction.bottom,
        Direction.bottom => Direction.top,
        Direction.left => Direction.right,
        Direction.right => Direction.left,
      };
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
