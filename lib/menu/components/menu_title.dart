
import 'package:bullet_train/design/colors.dart';
import 'package:bullet_train/menu/components/neon_effect.dart';
import 'package:flutter/material.dart';

class MenuTitle extends StatelessWidget {
  const MenuTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      children: [
        NeonEffect(
          color: ConnectColors.error,
          child: Text('弾丸列車',
            style: TextStyle(
              color: ConnectColors.error,
              fontWeight: FontWeight.w900,
              fontSize: 80,
            ),
          ),
        ),
        NeonEffect(
          color: ConnectColors.error,
          child: Text('BULLET TRAIN',
            style: TextStyle(
              color: ConnectColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 60,
            ),
          ),
        ),
      ],
    );
  }
}
