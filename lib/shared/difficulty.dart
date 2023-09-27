
enum Difficulty {
  easy, medium, hard;

  static List<Difficulty> get entries => [easy, medium, hard];

  String get label {
    final String label;

    switch (this) {
      case easy:
        label = 'facile';
      case medium:
        label = 'moyen';
      case hard:
        label = 'difficile';
    }

    return label;
  }

  int get intValue {
    final int difficulty;

    switch (this) {
      case easy:
        difficulty = 1;
      case medium:
        difficulty = 2;
      case hard:
        difficulty = 3;
    }

    return difficulty;
  }
}
