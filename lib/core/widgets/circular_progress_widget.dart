import 'package:auto_size_text/auto_size_text.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

enum CircularProgressStyle { full, semi }

class CircularProgressWidget extends StatefulWidget {
  const CircularProgressWidget({
    super.key,
    required this.progressValue,
    required this.maxValue,
    required this.title,
    this.subtitle,
    this.style = CircularProgressStyle.full,
    this.animateOnce = false,
  });

  final double progressValue;
  final double maxValue;
  final String title;
  final String? subtitle;
  final CircularProgressStyle style;
  final bool animateOnce;

  @override
  State<CircularProgressWidget> createState() => _CircularProgressWidgetState();
}

class _CircularProgressWidgetState extends State<CircularProgressWidget>
    with AutomaticKeepAliveClientMixin {
  bool _hasAnimated = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

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

    final subtitle = widget.subtitle;

    Widget child = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            widget.title,
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

    bool shouldAnimate = !_hasAnimated;

    switch (widget.style) {
      case CircularProgressStyle.full:
        progressBar = DashedCircularProgressBar.aspectRatio(
          aspectRatio: 1.0,
          startAngle: 180,
          corners: StrokeCap.butt,
          animation: shouldAnimate,
          progress: widget.progressValue,
          maxProgress: widget.maxValue,
          foregroundStrokeWidth: 5,
          backgroundStrokeWidth: 5,
          foregroundColor: Color.fromRGBO(72, 163, 136, 1),
          backgroundColor: Color.fromRGBO(169, 234, 206, 1),
          child: child,
        );
      case CircularProgressStyle.semi:
        progressBar = DashedCircularProgressBar.aspectRatio(
          aspectRatio: 1,
          progress: widget.progressValue,
          maxProgress: widget.maxValue,
          startAngle: 225,
          sweepAngle: 270,
          foregroundColor: Color.fromRGBO(72, 163, 136, 1),
          backgroundColor: Color.fromRGBO(169, 234, 206, 1),
          foregroundStrokeWidth: 8,
          backgroundStrokeWidth: 8,
          animation: shouldAnimate,
          seekSize: 4,
          seekColor: Colors.white,
          child: child,
        );
    }

    return VisibilityDetector(
      key: widget.key ?? Key('haousnlfiuhaoisdf'),
      onVisibilityChanged: (info) {
        final visiblePercentage = info.visibleFraction * 100;
        if (visiblePercentage >= 90 && !_hasAnimated) {
          _hasAnimated = true;
        }
      },
      child: SizedBox(
        height: 100,
        child: progressBar,
      ),
    );
  }
}
