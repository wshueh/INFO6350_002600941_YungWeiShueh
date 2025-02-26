import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onTap;

  OptionButton(
      {required this.option, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blueAccent : null,
      ),
      child: Text(option, style: TextStyle(fontSize: 18)),
    );
  }
}
