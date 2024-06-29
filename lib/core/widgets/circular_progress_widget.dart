import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({
    super.key,
    required this.progressValue,
    required this.maxValue,
    required this.title,
    this.subtitle,
  });

  final double progressValue;
  final double maxValue;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final scoreStyle = textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 27,
      color: Color.fromRGBO(42, 30, 57, 1),
    );

    final ratingStyle = textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: Color.fromRGBO(42, 30, 57, 1),
    );

    final subtitle = this.subtitle;

    return SizedBox(
      height: 90,
      child: DashedCircularProgressBar.aspectRatio(
        aspectRatio: 1.0,
        startAngle: 180,
        corners: StrokeCap.butt,
        animation: true,
        progress: progressValue,
        maxProgress: maxValue,
        foregroundStrokeWidth: 5,
        backgroundStrokeWidth: 5,
        foregroundColor: Color.fromRGBO(72, 163, 136, 1),
        backgroundColor: Color.fromRGBO(169, 234, 206, 1),
        child: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: scoreStyle),
                if (subtitle != null) Text(subtitle, style: ratingStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
