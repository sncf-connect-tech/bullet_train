enum GameLayer {
  background(0),
  traveler(10),
  train(50);

  const GameLayer(this.priority);

  final int priority;
}
