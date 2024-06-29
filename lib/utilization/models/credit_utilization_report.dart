import 'package:ava_light/core/theme/colors.dart';
import 'package:flutter/material.dart';

final class CreditUtilizationReport {
  final double ratio;

  CreditUtilizationReport({required this.ratio});

  // source: https://www.experian.com/blogs/ask-experian/credit-education/score-basics/credit-utilization-rate/
  UtilizationGrade get grade {
    switch (ratio) {
      case >= 0.821:
        return UtilizationGrade.poor;
      case >= 0.561:
        return UtilizationGrade.fair;
      case >= 0.352:
        return UtilizationGrade.good;
      case >= 0.147:
        return UtilizationGrade.veryGood;
      case >= 0.065:
        return UtilizationGrade.exceptional;
      default:
        return UtilizationGrade.unknown;
    }
  }
}

enum UtilizationGrade {
  poor,
  fair,
  good,
  veryGood,
  exceptional,
  unknown;

  String get stringValue {
    switch (this) {
      case UtilizationGrade.unknown:
        return "Unknown";
      case UtilizationGrade.poor:
        return "Poor";
      case UtilizationGrade.fair:
        return "Fair";
      case UtilizationGrade.good:
        return "Good";
      case UtilizationGrade.veryGood:
        return "Very Good";
      case UtilizationGrade.exceptional:
        return "Exceptional";
    }
  }

  Color get colorValue {
    switch (this) {
      case UtilizationGrade.unknown:
        return AvaColors.cardBorderColor;
      case UtilizationGrade.poor:
        return AvaColors.darkRed;
      case UtilizationGrade.fair:
        return AvaColors.orange;
      case UtilizationGrade.good:
        return AvaColors.darkYellow;
      case UtilizationGrade.veryGood:
        return AvaColors.lightGreen;
      case UtilizationGrade.exceptional:
        return AvaColors.green;
    }
  }
}
