import 'package:bullet_train/design/design.dart';
import 'package:flutter/widgets.dart';

class MenuImage extends StatelessWidget {
  const MenuImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NeonEffect(
      child: Image.asset(
        fit: BoxFit.fitHeight,
        alignment: Alignment.bottomCenter,
        'assets/images/characters.png',
      ),
    );
  }
}
