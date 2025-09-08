import 'package:flutter/material.dart';

/// A small, rounded badge widget for displaying short text with color-coded background.
/// 
/// The pill widget creates a compact, stadium-shaped (rounded ends) container
/// with text, commonly used for status indicators, badges, and small labels
/// throughout the application.
/// 
/// Common usage patterns:
/// * Score change indicators ("+15pts", "-5pts")
/// * Credit factor impact levels ("HIGH IMPACT", "LOW IMPACT")
/// * Status badges ("PAID", "OVERDUE", "CURRENT")
/// * Category labels and tags
/// 
/// Design characteristics:
/// * Stadium border (fully rounded ends) for modern appearance
/// * Compact horizontal padding (6px) for tight spacing
/// * White text for maximum contrast on colored backgrounds
/// * Bold font weight (600) for readability at small sizes
/// * Fixed font size (14px) for consistency
/// 
/// Example usage:
/// ```dart
/// // Credit score change indicator
/// PillWidget(
///   text: '+15pts',
///   color: Colors.green,
/// )
/// 
/// // Credit factor impact
/// PillWidget(
///   text: 'HIGH IMPACT',
///   color: AvaColors.darkGreen,
/// )
/// 
/// // Status indicator
/// PillWidget(
///   text: 'CURRENT',
///   color: AvaColors.blue,
/// )
/// ```
/// 
/// Color conventions in the app:
/// * Green tones: Positive changes, high impact, good status
/// * Red tones: Negative changes, alerts, overdue status
/// * Blue tones: Neutral information, current status
/// * Purple tones: Special categories, premium features
/// 
/// See also:
/// * [CreditImpact] extension for standardized impact level colors
/// * [ScoreDiffWidget] for specific score change display logic
class PillWidget extends StatelessWidget {
  /// Creates a pill-shaped badge with text and background color.
  /// 
  /// Both [text] and [color] are required parameters:
  /// * [text] - The text to display inside the pill
  /// * [color] - The background color of the pill
  const PillWidget({super.key, required this.text, required this.color});

  /// The text content displayed inside the pill.
  /// 
  /// Should be short and concise for best visual results.
  /// Common patterns include:
  /// * Score changes: "+15pts", "-5pts"
  /// * Impact levels: "HIGH IMPACT", "MEDIUM IMPACT"  
  /// * Status indicators: "PAID", "PENDING", "OVERDUE"
  /// * Categories: "NEW", "FEATURED", "PREMIUM"
  final String text;
  
  /// The background color of the pill.
  /// 
  /// Should provide sufficient contrast with white text for accessibility.
  /// Consider using colors from the app's theme ([AvaColors]) for consistency.
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
