import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

const int kMaxScoreRating = 850;

@immutable
final class CreditReport extends Equatable {
  final DateTime dateReported;
  final int score;
  final CreditReportAgency agency;

  CreditReport({
    required this.dateReported,
    required this.score,
    required this.agency,
  });

  CreditScoreRating get rating {
    switch (score) {
      case >= 300 && <= 579:
        return CreditScoreRating.poor;
      case >= 580 && <= 669:
        return CreditScoreRating.fair;
      case >= 670 && <= 739:
        return CreditScoreRating.good;
      case >= 740 && <= 799:
        return CreditScoreRating.veryGood;
      case >= 800 && <= 850:
        return CreditScoreRating.exceptional;
      default:
        return CreditScoreRating.unknown;
    }
  }

  @override
  List<Object?> get props => [dateReported, score, agency];
}

enum CreditReportAgency {
  experian,
  equifax,
  transUnion;

  String get string {
    switch (this) {
      case CreditReportAgency.experian:
        return "Experian";
      case CreditReportAgency.equifax:
        return "Equifax";
      case CreditReportAgency.transUnion:
        return "TransUnion";
    }
  }
}

enum CreditScoreRating {
  unknown,
  poor,
  fair,
  good,
  veryGood,
  exceptional;

  String get string {
    switch (this) {
      case CreditScoreRating.unknown:
        return "Unknown";
      case CreditScoreRating.poor:
        return "Poor";
      case CreditScoreRating.fair:
        return "Fair";
      case CreditScoreRating.good:
        return "Good";
      case CreditScoreRating.veryGood:
        return "Very Good";
      case CreditScoreRating.exceptional:
        return "Exceptional";
    }
  }
}
