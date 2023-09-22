import 'dart:ui';

enum PassengerType {
  badGuy,
  goodGuy,
}

typedef Passengers = List<Passenger>;

class Passenger {
  Passenger({required this.type, required this.position});

  final PassengerType type;
  final Offset position;

  double get radius => switch (type) {
        PassengerType.badGuy => 2,
        PassengerType.goodGuy => 1,
      };
}
