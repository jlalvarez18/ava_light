import 'package:auto_size_text/auto_size_text.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Display styles for the circular progress indicator.
/// 
/// Determines the visual appearance and arc coverage of the progress ring.
enum CircularProgressStyle { 
  /// Complete circular progress indicator (360°).
  /// 
  /// Displays a full circle progress ring, typically used for credit scores
  /// and other metrics where the full range is meaningful.
  full, 
  
  /// Semi-circular progress indicator (270°).
  /// 
  /// Displays a partial arc progress ring, commonly used for utilization
  /// percentages and metrics where space is constrained.
  semi 
}

/// A customizable circular progress indicator widget for displaying scores and percentages.
/// 
/// This widget provides a visually appealing way to display numerical progress with
/// accompanying text labels. It supports both full circle and semi-circle styles,
/// with configurable animation behavior and responsive text sizing.
/// 
/// The widget is commonly used throughout the app for:
/// * Credit score displays (typically 300-850 range)
/// * Credit utilization percentages (0-100%)
/// * Progress indicators with custom ranges
/// * Data visualization components
/// 
/// Key features:
/// * Two display styles: full circle (360°) and semi-circle (270°)
/// * Smooth animations with optional single-trigger behavior
/// * Responsive text sizing with [AutoSizeText]
/// * Custom styling with Google Fonts (Space Mono for numbers)
/// * Visibility-based animation triggering
/// * Theme-aware color scheme
/// 
/// Example usage:
/// ```dart
/// // Credit score display
/// CircularProgressWidget(
///   progressValue: 720,
///   maxValue: 850,
///   title: '720',
///   subtitle: 'Good',
///   style: CircularProgressStyle.full,
///   animateOnce: true,
/// )
/// 
/// // Utilization percentage
/// CircularProgressWidget(
///   progressValue: 0.25,
///   maxValue: 1.0,
///   title: '25%',
///   subtitle: 'Utilization',
///   style: CircularProgressStyle.semi,
///   animateOnce: true,
/// )
/// ```
/// 
/// Performance considerations:
/// * Uses [AutomaticKeepAliveClientMixin] to preserve state during scroll
/// * [animateOnce] parameter prevents re-animation on visibility changes
/// * [VisibilityDetector] manages animation lifecycle efficiently
/// 
/// See also:
/// * [DashedCircularProgressBar] for the underlying progress rendering
/// * [CircularProgressStyle] for available display styles
/// * [AutoSizeText] for responsive text scaling
class CircularProgressWidget extends StatefulWidget {
  /// Creates a circular progress indicator widget.
  /// 
  /// All required parameters must be provided:
  /// * [progressValue] - Current progress value
  /// * [maxValue] - Maximum possible value for progress calculation
  /// * [title] - Primary text displayed in the center (typically the numeric value)
  /// 
  /// Optional parameters:
  /// * [subtitle] - Secondary text below the title (e.g., rating, description)
  /// * [style] - Display style, defaults to [CircularProgressStyle.full]
  /// * [animateOnce] - If true, animation only triggers once per widget instance
  const CircularProgressWidget({
    super.key,
    required this.progressValue,
    required this.maxValue,
    required this.title,
    this.subtitle,
    this.style = CircularProgressStyle.full,
    this.animateOnce = false,
  });

  /// The current progress value to display.
  /// 
  /// This value is used to calculate the progress percentage as:
  /// `progressValue / maxValue`. The value should be within the range
  /// of 0 to [maxValue].
  /// 
  /// Examples:
  /// * Credit score: 720 (out of 850)
  /// * Utilization: 0.25 (out of 1.0 for 25%)
  final double progressValue;
  
  /// The maximum possible value for progress calculation.
  /// 
  /// Used as the denominator in progress percentage calculation.
  /// Common values include:
  /// * Credit scores: 850 (industry maximum)
  /// * Percentages: 1.0 (for decimal representation)
  /// * Custom ranges: Any positive number
  final double maxValue;
  
  /// The primary text displayed in the center of the progress indicator.
  /// 
  /// Typically shows the numeric value being represented, formatted
  /// appropriately for the context. Uses Space Mono font for numeric clarity.
  /// 
  /// Examples: "720", "25%", "$1,250"
  final String title;
  
  /// Optional secondary text displayed below the title.
  /// 
  /// Usually provides context or categorization for the primary value.
  /// Uses regular app font with smaller size and secondary styling.
  /// 
  /// Examples: "Good", "Utilization", "Above Average"
  final String? subtitle;
  
  /// The visual style of the progress indicator.
  /// 
  /// Determines whether to display a full circle or semi-circle arc.
  /// Defaults to [CircularProgressStyle.full].
  final CircularProgressStyle style;
  
  /// Controls animation behavior on visibility changes.
  /// 
  /// When `true`, the widget will only animate once when it becomes visible,
  /// preventing re-animation on subsequent visibility changes (e.g., scrolling).
  /// When `false`, the widget animates every time it becomes visible.
  /// 
  /// Recommended to set `true` for better user experience and performance.
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
