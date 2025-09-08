import 'package:ava_light/core/theme/colors.dart';
import 'package:flutter/material.dart';

/// Represents a factor that influences an individual's credit score.
/// 
/// Credit factors are individual components that credit scoring models
/// use to calculate overall credit scores. Each factor has a title,
/// current value/status, and impact level indicating how significantly
/// it affects the overall score.
/// 
/// Common credit factors include:
/// * Payment history (typically highest impact)
/// * Credit utilization (high impact)
/// * Length of credit history (medium impact)
/// * Credit mix (lower impact)
/// * New credit inquiries (lower impact)
/// 
/// Example:
/// ```dart
/// final factor = CreditFactor(
///   title: 'Payment History',
///   value: '100%',
///   impact: CreditImpact.high,
/// );
/// 
/// print(factor.impact.string); // "HIGH IMPACT"
/// print(factor.impact.color);  // Dark green color
/// ```
/// 
/// See also:
/// * [CreditImpact] for impact level definitions and styling
@immutable
final class CreditFactor {
  /// The name or category of this credit factor.
  /// 
  /// Examples: "Payment History", "Credit Card Utilization", "Derogatory Marks"
  final String title;
  
  /// The current value or status of this factor.
  /// 
  /// This could be a percentage, amount, count, or status string.
  /// Examples: "100%", "$1,234", "0 accounts", "On time"
  final String value;
  
  /// The impact level of this factor on the overall credit score.
  /// 
  /// Determines the visual styling and importance indicator shown to users.
  final CreditImpact impact;

  /// Creates a new credit factor instance.
  /// 
  /// All parameters are required:
  /// * [title] - The name/category of the factor
  /// * [value] - Current value or status
  /// * [impact] - Impact level on credit score
  CreditFactor({
    required this.title,
    required this.value,
    required this.impact,
  });
}

/// The level of impact a credit factor has on the overall credit score.
/// 
/// Credit factors are weighted differently in scoring algorithms, with
/// some factors having more influence on the final score than others.
/// This enum categorizes that influence into three levels.
/// 
/// Impact levels from highest to lowest influence:
/// * [high] - Major factors like payment history and credit utilization
/// * [medium] - Moderate factors like credit history length
/// * [low] - Minor factors like credit mix and new inquiries
/// 
/// Each impact level has associated colors and text for consistent UI display.
enum CreditImpact { 
  /// High impact factors significantly affect credit scores.
  /// 
  /// Typically includes payment history and credit utilization.
  /// Displayed with dark green background and white text.
  high, 
  
  /// Medium impact factors moderately affect credit scores.
  /// 
  /// Typically includes length of credit history and types of credit.
  /// Displayed with medium green background and white text.
  medium, 
  
  /// Low impact factors have minimal effect on credit scores.
  /// 
  /// Typically includes new credit inquiries and credit mix diversity.
  /// Displayed with light green background and dark green text.
  low 
}

/// Extension providing UI styling and display properties for [CreditImpact].
/// 
/// This extension centralizes the visual styling for credit impact levels,
/// ensuring consistent colors and text throughout the application.
extension CreditImpactExtension on CreditImpact {
  /// The background color to use when displaying this impact level.
  /// 
  /// Colors range from dark green (high impact) to light green (low impact)
  /// to create a visual hierarchy that users can quickly understand.
  Color get color {
    switch (this) {
      case CreditImpact.high:
        return AvaColors.darkGreen;
      case CreditImpact.medium:
        return AvaColors.green;
      case CreditImpact.low:
        return AvaColors.lightGreen;
    }
  }

  /// The uppercase string representation of this impact level.
  /// 
  /// Returns formatted strings suitable for display in UI badges
  /// and impact indicators.
  /// 
  /// Examples: "HIGH IMPACT", "MEDIUM IMPACT", "LOW IMPACT"
  String get string {
    switch (this) {
      case CreditImpact.high:
        return "HIGH IMPACT";
      case CreditImpact.medium:
        return "MEDIUM IMPACT";
      case CreditImpact.low:
        return "LOW IMPACT";
    }
  }

  /// The text color to use when displaying this impact level.
  /// 
  /// Ensures proper contrast against the background color:
  /// * High/Medium impact: White text on dark/medium green background
  /// * Low impact: Dark green text on light green background
  Color get textColor {
    switch (this) {
      case CreditImpact.high:
        return Colors.white;
      case CreditImpact.medium:
        return Colors.white;
      case CreditImpact.low:
        return AvaColors.darkGreen;
    }
  }
}
