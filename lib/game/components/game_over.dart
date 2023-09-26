import 'dart:ui';

import 'package:bullet_train/design/design.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  const GameOver({
    super.key,
    this.onPressContinue,
    this.onPressLeave,
  });

  final VoidCallback? onPressContinue;
  final VoidCallback? onPressLeave;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 600,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: Dimens.blurSigma,
              sigmaY: Dimens.blurSigma,
            ),
            child: Container(color: Colors.transparent),
          ),
          Column(
            children: [
              const Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                children: [
                  NeonEffect(
                    color: ConnectColors.error,
                    child: Text(
                      'ゲームオーバー',
                      style: TextStyle(
                        color: ConnectColors.error,
                        fontWeight: FontWeight.w900,
                        fontSize: 80,
                      ),
                    ),
                  ),
                  NeonEffect(
                    color: ConnectColors.error,
                    child: Text(
                      'GAME OVER',
                      style: TextStyle(
                        color: ConnectColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 60,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimens.minColumnSpacing),
              Expanded(
                child: NavigationButton(
                  title: 'Rejouer',
                  onPressed: () => onPressContinue?.call(),
                ),
              ),
              const SizedBox(height: Dimens.minColumnSpacing),
              Expanded(
                child: NavigationButton(
                  title: "Retour à l'écran titre",
                  onPressed: () => onPressLeave?.call(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
