import 'package:ava_light/core/theme/colors.dart';
import 'package:flutter/material.dart';

/// A reusable card widget that provides consistent styling throughout the app.
/// 
/// This widget creates a rounded container with a consistent visual design
/// including background color, border, shadow, and padding. It serves as the
/// foundation for most content sections in the application.
/// 
/// The card follows the app's design system with:
/// * Rounded corners (24px radius) for modern appearance
/// * Subtle border for definition without being intrusive
/// * Consistent background color from the theme
/// * Standard padding (20px) with customization option
/// * Elevation/shadow for visual hierarchy
/// 
/// Common usage patterns:
/// * Account information displays
/// * Credit factor listings
/// * Chart containers
/// * Settings panels
/// * Summary sections
/// 
/// Example usage:
/// ```dart
/// CardWidget(
///   child: Column(
///     children: [
///       Text('Account Balance'),
///       Text('\$1,250.00'),
///     ],
///   ),
/// )
/// 
/// // With custom padding
/// CardWidget(
///   padding: EdgeInsets.all(16),
///   child: CreditScoreChart(),
/// )
/// ```
/// 
/// Design considerations:
/// * Uses [AvaColors.cardColor] for consistent theming
/// * Border color from [AvaColors.cardBorderColor] for subtle definition
/// * Rounded corners create friendly, approachable interface
/// * Default padding suitable for most content types
/// 
/// See also:
/// * [AvaColors] for theme color definitions
/// * [Container] for the underlying widget implementation
class CardWidget extends StatelessWidget {
  /// Creates a card widget with consistent app styling.
  /// 
  /// The [child] parameter is required and will be wrapped with the card
  /// decoration and padding.
  /// 
  /// The [padding] parameter is optional and defaults to 20px on all sides.
  /// This can be customized based on the content requirements.
  const CardWidget({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  /// The padding applied inside the card around the child widget.
  /// 
  /// Defaults to 20px on all sides, which works well for most content.
  /// Can be customized for specific content requirements:
  /// * Smaller padding: `EdgeInsets.all(12)` for compact content
  /// * Asymmetric padding: `EdgeInsets.symmetric(horizontal: 24, vertical: 16)`
  /// * Zero padding: `EdgeInsets.zero` when child handles its own spacing
  final EdgeInsets padding;
  
  /// The widget to display inside the card.
  /// 
  /// This is typically a Column, Row, or other layout widget containing
  /// the actual content to be displayed within the card container.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: AvaColors.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: AvaColors.cardBorderColor),
        ),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
