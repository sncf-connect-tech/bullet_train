import 'package:bullet_train/design/colors.dart';
import 'package:bullet_train/shared/difficulty.dart';
import 'package:flutter/material.dart';

class DifficultySelector extends StatelessWidget {
  const DifficultySelector({
    required this.initialDifficulty,
    required this.onSelected,
    super.key,
  });

  final Difficulty initialDifficulty;
  final ValueChanged<Difficulty?> onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      label: const Text('Difficulté'),
      textStyle: const TextStyle(color: ConnectColors.textPrimary),
      initialSelection: initialDifficulty,
      onSelected: onSelected,
      dropdownMenuEntries: Difficulty.entries.map((difficulty) {
        return DropdownMenuEntry(
          value: difficulty,
          label: difficulty.label,
        );
      }).toList(),
    );
  }
}
