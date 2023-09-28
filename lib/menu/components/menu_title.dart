import 'package:bullet_train/design/design.dart';
import 'package:flutter/material.dart';

class MenuTitle extends StatelessWidget {
  const MenuTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      children: [
        NeonEffect(
          child: Text(
            '弾丸列車',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        NeonEffect(
          child: Text(
            'BULLET TRAIN',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
