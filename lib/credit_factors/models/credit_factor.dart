import 'package:ava_light/core/theme/colors.dart';
import 'package:flutter/material.dart';

@immutable
final class CreditFactor {
  final String title;
  final String value;
  final CreditImpact impact;

  CreditFactor({
    required this.title,
    required this.value,
    required this.impact,
  });
}

enum CreditImpact { high, medium, low }

extension CreditImpactExtension on CreditImpact {
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
