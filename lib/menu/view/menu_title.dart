import 'package:bullet_train/design/design.dart';
import 'package:flutter/material.dart';

class MenuTitle extends StatelessWidget {
  const MenuTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FractionallySizedBox(
      heightFactor: 0.6,
      child: FittedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            NeonEffect(
              child: Text(
                '弾丸列車',
                style: textTheme.titleLarge,
              ),
            ),
            NeonEffect(
              child: Text(
                'BULLET TRAIN',
                style: textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
