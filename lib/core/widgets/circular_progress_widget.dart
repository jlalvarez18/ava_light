import 'package:auto_size_text/auto_size_text.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum CircularProgressStyle { full, semi }

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({
    super.key,
    required this.progressValue,
    required this.maxValue,
    required this.title,
    this.subtitle,
    this.style = CircularProgressStyle.full,
  });

  final double progressValue;
  final double maxValue;
  final String title;
  final String? subtitle;
  final CircularProgressStyle style;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final scoreStyle = GoogleFonts.spaceMono(
      textStyle: textTheme.titleLarge,
      color: Color.fromRGBO(42, 30, 57, 1),
      fontWeight: FontWeight.w600,
      fontSize: 27,
      letterSpacing: .5,
    );

    final subtitleStyle = textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: Color.fromRGBO(42, 30, 57, 1),
    );

    final subtitle = this.subtitle;

    Widget child = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            title,
            style: scoreStyle,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
          if (subtitle != null)
            AutoSizeText(
              subtitle,
              minFontSize: 5,
              style: subtitleStyle,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );

    Widget progressBar;

    switch (style) {
      case CircularProgressStyle.full:
        progressBar = DashedCircularProgressBar.aspectRatio(
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
          child: child,
        );
      case CircularProgressStyle.semi:
        progressBar = DashedCircularProgressBar.aspectRatio(
          aspectRatio: 1,
          progress: progressValue,
          maxProgress: maxValue,
          startAngle: 225,
          sweepAngle: 270,
          foregroundColor: Color.fromRGBO(72, 163, 136, 1),
          backgroundColor: Color.fromRGBO(169, 234, 206, 1),
          foregroundStrokeWidth: 8,
          backgroundStrokeWidth: 8,
          animation: true,
          seekSize: 4,
          seekColor: Colors.white,
          child: child,
        );
    }

    return SizedBox(
      height: 100,
      child: progressBar,
    );
  }
}
