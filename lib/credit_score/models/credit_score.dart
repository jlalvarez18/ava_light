import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// The maximum possible credit score rating across all credit reporting agencies.
/// 
/// This constant is used for calculating progress percentages and determining
/// score visualization ranges in circular progress indicators.
const int kMaxScoreRating = 850;

/// Represents a credit score report from a specific credit reporting agency.
/// 
/// This immutable data class encapsulates a credit score reading at a specific
/// point in time, including the reporting agency and calculated rating category.
/// 
/// Credit scores typically range from 300-850, with higher scores indicating
/// better creditworthiness. The [rating] property automatically categorizes
/// the score into standardized ranges (Poor, Fair, Good, Very Good, Exceptional).
/// 
/// Example:
/// ```dart
/// final report = CreditReport(
///   dateReported: DateTime(2024, 6, 1),
///   score: 720,
///   agency: CreditReportAgency.experian,
/// );
/// 
/// print(report.rating); // CreditScoreRating.good
/// print(report.agency.string); // "Experian"
/// ```
/// 
/// See also:
/// * [CreditReportAgency] for supported credit reporting agencies
/// * [CreditScoreRating] for score classification ranges
@immutable
final class CreditReport extends Equatable {
  /// The date when this credit score was reported or calculated.
  final DateTime dateReported;
  
  /// The credit score value, typically ranging from 300 to 850.
  final int score;
  
  /// The credit reporting agency that provided this score.
  final CreditReportAgency agency;

  /// Creates a new credit report instance.
  /// 
  /// All parameters are required and must be valid:
  /// * [dateReported] - When the score was generated
  /// * [score] - The numeric credit score (typically 300-850)  
  /// * [agency] - Which credit bureau provided the score
  CreditReport({
    required this.dateReported,
    required this.score,
    required this.agency,
  });

  /// Automatically categorizes the credit score into a standardized rating.
  /// 
  /// Uses industry-standard score ranges to classify creditworthiness:
  /// * 300-579: Poor
  /// * 580-669: Fair  
  /// * 670-739: Good
  /// * 740-799: Very Good
  /// * 800-850: Exceptional
  /// * Outside ranges: Unknown
  /// 
  /// This computed property is used throughout the UI to display
  /// user-friendly rating labels alongside numeric scores.
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

/// The three major credit reporting agencies in the United States.
/// 
/// These agencies collect and maintain credit information about consumers,
/// providing credit reports and scores to lenders and consumers.
/// 
/// Each agency may have slightly different scoring models and data,
/// so credit scores can vary between agencies for the same individual.
/// 
/// Example:
/// ```dart
/// final agency = CreditReportAgency.experian;
/// print(agency.string); // "Experian"
/// ```
enum CreditReportAgency {
  /// Experian - One of the three major credit bureaus.
  experian,
  
  /// Equifax - One of the three major credit bureaus.
  equifax,
  
  /// TransUnion - One of the three major credit bureaus.
  transUnion;

  /// Returns the human-readable name of the credit reporting agency.
  /// 
  /// Used throughout the UI to display agency names to users.
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

/// Standardized credit score rating categories based on industry ranges.
/// 
/// These ratings provide a user-friendly way to understand credit score quality
/// without needing to memorize numeric ranges. Each rating corresponds to
/// specific score ranges that are widely recognized in the credit industry.
/// 
/// Rating ranges:
/// * [poor]: 300-579 (Significant credit challenges)
/// * [fair]: 580-669 (Below average, may face higher interest rates)
/// * [good]: 670-739 (Above average, generally favorable terms)
/// * [veryGood]: 740-799 (Well above average, excellent terms available)
/// * [exceptional]: 800-850 (Excellent credit, best available terms)
/// * [unknown]: Outside standard ranges or unclassified
/// 
/// Example:
/// ```dart
/// final rating = CreditScoreRating.good;
/// print(rating.string); // "Good"
/// ```
enum CreditScoreRating {
  /// Unknown or unclassified score (outside standard ranges).
  unknown,
  
  /// Poor credit (300-579) - Significant credit challenges.
  poor,
  
  /// Fair credit (580-669) - Below average, may face higher rates.
  fair,
  
  /// Good credit (670-739) - Above average, generally favorable terms.
  good,
  
  /// Very good credit (740-799) - Well above average, excellent terms.
  veryGood,
  
  /// Exceptional credit (800-850) - Excellent credit, best available terms.
  exceptional;

  /// Returns the human-readable name of the credit score rating.
  /// 
  /// Used throughout the UI to display rating labels to users alongside
  /// or instead of numeric credit scores.
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
