import 'package:bullet_train/design/design.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  const GameOver({
    required this.isVisible,
    this.onPressContinue,
    this.onPressLeave,
    super.key,
  });

  final bool isVisible;
  final VoidCallback? onPressContinue;
  final VoidCallback? onPressLeave;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isVisible,
      child: AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 1000),
        child: Container(
          decoration: BoxDecoration(
            color: ConnectColors.background.withOpacity(0.75),
            borderRadius: BorderRadius.circular(45),
          ),
          height: 350 + Dimens.columnSpacing * 2,
          width: 600 + Dimens.rowSpacing * 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.rowSpacing,
              vertical: Dimens.columnSpacing,
            ),
            child: Column(
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
                          fontSize: 60,
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
                NavigationButton(
                  title: 'Rejouer',
                  onPressed: () => onPressContinue?.call(),
                ),
                const SizedBox(height: Dimens.minColumnSpacing),
                NavigationButton(
                  title: "Retour à l'écran titre",
                  onPressed: () => onPressLeave?.call(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
