enum GameLayer {
  background(0),
  train(50);

  const GameLayer(this.priority);

  final int priority;
}
