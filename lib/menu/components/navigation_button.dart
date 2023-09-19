import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const NavigationButton({
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Center(
        child: Text(title),
      ),
    );
  }
}
