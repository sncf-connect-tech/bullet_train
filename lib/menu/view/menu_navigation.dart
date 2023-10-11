import 'package:flutter/material.dart';

class MenuNavigation extends StatelessWidget {
  const MenuNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Jouer'),
      onPressed: () {
        Navigator.of(context).pushNamed('/game');
      },
    );
  }
}
