import 'package:flutter/material.dart';
import '../models/app_state.dart';
import 'widgets.dart';

class YesNoSelection extends StatelessWidget {
  const YesNoSelection({
    super.key,
    required this.state,
    required this.onSelection,
  });

  final Attending state;
  final void Function(Attending selection) onSelection;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case Attending.yes:
        return buttonRow(
          yesFilled: true,
          noFilled: false,
        );
      case Attending.no:
        return buttonRow(
          yesFilled: false,
          noFilled: true,
        );
      default:
        return buttonRow();
    }
  }

  Widget buttonRow({bool yesFilled = false, bool noFilled = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          yesFilled
              ? FilledButton(
                  onPressed: () => onSelection(Attending.yes),
                  child: const Text('YES'),
                )
              : TextButton(
                  onPressed: () => onSelection(Attending.yes),
                  child: const Text('YES'),
                ),
          const SizedBox(width: 8),
          noFilled
              ? FilledButton(
                  onPressed: () => onSelection(Attending.no),
                  child: const Text('NO'),
                )
              : TextButton(
                  onPressed: () => onSelection(Attending.no),
                  child: const Text('NO'),
                ),
        ],
      ),
    );
  }
}
