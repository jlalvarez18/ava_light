import 'package:flutter/material.dart';

class PillWidget extends StatelessWidget {
  const PillWidget({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final diffScoreStyle = textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: Colors.white,
    );
    return Container(
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          text,
          style: diffScoreStyle,
        ),
      ),
    );
  }
}
