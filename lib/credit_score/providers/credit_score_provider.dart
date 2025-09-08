import 'package:ava_light/core/extensions/list_extensions.dart';
import 'package:ava_light/credit_score/models/credit_score.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'credit_score_provider.g.dart';

/// Provides a collection of Experian credit reports in chronological order.
/// 
/// This provider returns historical credit score data from Experian, one of the
/// three major credit reporting agencies. The data is sorted from most recent
/// to oldest, allowing for trend analysis and score difference calculations.
/// 
/// The sample data represents typical credit score variations over time,
/// demonstrating both improvements and temporary decreases that can occur
/// in real credit profiles.
/// 
/// Example usage:
/// ```dart
/// final reports = ref.watch(getExperianReportsProvider);
/// final latestScore = reports.first.score; // Most recent score
/// final trend = reports.first.score - reports[1].score; // Score change
/// ```
/// 
/// See also:
/// * [latestExperianReportProvider] for the most recent report
/// * [latestScoreDiffProvider] for calculated score changes
@riverpod
List<CreditReport> getExperianReports(GetExperianReportsRef ref) {
  final reports = [
    CreditReport(
      dateReported: DateTime(2024, 6, 1),
      score: 690,
      agency: CreditReportAgency.experian,
    ),
    CreditReport(
      dateReported: DateTime(2024, 5, 1),
      score: 705,
      agency: CreditReportAgency.experian,
    ),
    CreditReport(
      dateReported: DateTime(2024, 4, 1),
      score: 675,
      agency: CreditReportAgency.experian,
    ),
    CreditReport(
      dateReported: DateTime(2024, 4, 1),
      score: 650,
      agency: CreditReportAgency.experian,
    ),
    CreditReport(
      dateReported: DateTime(2024, 3, 1),
      score: 660,
      agency: CreditReportAgency.experian,
    ),
    CreditReport(
      dateReported: DateTime(2024, 2, 1),
      score: 650,
      agency: CreditReportAgency.experian,
    ),
    CreditReport(
      dateReported: DateTime(2024, 1, 1),
      score: 640,
      agency: CreditReportAgency.experian,
    ),
    CreditReport(
      dateReported: DateTime(2023, 12, 1),
      score: 660,
      agency: CreditReportAgency.experian,
    ),
    CreditReport(
      dateReported: DateTime(2023, 11, 1),
      score: 620,
      agency: CreditReportAgency.experian,
    ),
    CreditReport(
      dateReported: DateTime(2023, 10, 1),
      score: 550,
      agency: CreditReportAgency.experian,
    ),
    CreditReport(
      dateReported: DateTime(2023, 9, 1),
      score: 620,
      agency: CreditReportAgency.experian,
    ),
    CreditReport(
      dateReported: DateTime(2023, 8, 1),
      score: 600,
      agency: CreditReportAgency.experian,
    ),
  ];

  return reports;
}

/// Provides Experian credit reports sorted by date with optional limiting.
/// 
/// This provider takes the raw Experian reports and sorts them chronologically,
/// with configurable sort direction and result limiting. This is useful for
/// creating charts, analyzing trends, and displaying recent history.
/// 
/// Parameters:
/// * [ascending] - If true, sorts oldest to newest; if false, newest to oldest (default: true)
/// * [limit] - Maximum number of reports to return (default: 12)
/// 
/// The default configuration returns the last 12 months of data in chronological
/// order, which is ideal for line charts and trend visualization.
/// 
/// Example usage:
/// ```dart
/// // Get last 12 months for chart display
/// final chartData = ref.watch(getSortedExperianReportsProvider);
/// 
/// // Get most recent 6 reports
/// final recent = ref.watch(getSortedExperianReportsProvider(
///   ascending: false, 
///   limit: 6
/// ));
/// ```
/// 
/// See also:
/// * [getExperianReportsProvider] for unsorted raw data
/// * [latestExperianReportProvider] for just the most recent report
@riverpod
List<CreditReport> getSortedExperianReports(GetSortedExperianReportsRef ref,
    {bool ascending = true, int limit = 12}) {
  final reports = ref.watch(getExperianReportsProvider);

  final sorted = reports.sortedBy(
    compare: (a, b) {
      var value = a.dateReported.compareTo(b.dateReported);

      if (!ascending && value != 0) {
        value = -value;
      }

      return value;
    },
  );

  if (sorted.length > limit) {
    return sorted;
  }

  return sorted.sublist(0, limit);
}

/// Provides the most recent Experian credit report.
/// 
/// This provider returns the latest credit score report from Experian,
/// which is typically used for displaying the current credit score in
/// headers, summaries, and primary UI components.
/// 
/// The report includes the score value, rating category, date reported,
/// and agency information. This is the most frequently accessed provider
/// for current credit status display.
/// 
/// Example usage:
/// ```dart
/// final latestReport = ref.watch(latestExperianReportProvider);
/// print('Current Score: ${latestReport.score}');
/// print('Rating: ${latestReport.rating.string}');
/// print('Updated: ${latestReport.dateReported}');
/// ```
/// 
/// See also:
/// * [latestScoreDiffProvider] for score change calculations
/// * [getSortedExperianReportsProvider] for historical data
@riverpod
CreditReport latestExperianReport(LatestExperianReportRef ref) {
  final reports = ref.watch(getSortedExperianReportsProvider(ascending: false));
  return reports[0];
}

/// Industry-standard credit score ranges for fallback calculations.
/// 
/// Source: https://www.capitalone.com/learn-grow/money-management/lowest-credit-score/
/// These constants provide fallback values when historical data is unavailable.
int _kMaxCreditScore = 850;
int _kMinCreditScore = 300;

/// Provides the lowest credit score from historical Experian reports.
/// 
/// This provider finds the minimum score across all available Experian reports,
/// which is useful for calculating score ranges, progress indicators, and
/// showing improvement over time.
/// 
/// Returns the actual minimum score from historical data, or falls back to
/// the industry minimum (300) if no reports are available.
/// 
/// Example usage:
/// ```dart
/// final minScore = ref.watch(minReportedExperianScoreProvider);
/// final currentScore = ref.watch(latestExperianReportProvider).score;
/// final improvement = currentScore - minScore; // Total improvement
/// ```
/// 
/// See also:
/// * [maxReportedExperianScoreProvider] for the historical maximum
/// * [latestExperianReportProvider] for current score
@riverpod
int minReportedExperianScore(MinReportedExperianScoreRef ref) {
  final reports = ref.watch(getSortedExperianReportsProvider());
  final sorted = reports.sortedBy(compare: (a, b) => a.score.compareTo(b.score));
  return sorted.firstOrNull?.score ?? _kMinCreditScore;
}

/// Provides the highest credit score from historical Experian reports.
/// 
/// This provider finds the maximum score across all available Experian reports,
/// which is useful for showing peak performance, calculating ranges, and
/// demonstrating credit score potential.
/// 
/// Returns the actual maximum score from historical data, or falls back to
/// the industry maximum (850) if no reports are available.
/// 
/// Example usage:
/// ```dart
/// final maxScore = ref.watch(maxReportedExperianScoreProvider);
/// final currentScore = ref.watch(latestExperianReportProvider).score;
/// final potential = maxScore - currentScore; // Room for improvement
/// ```
/// 
/// See also:
/// * [minReportedExperianScoreProvider] for the historical minimum
/// * [latestExperianReportProvider] for current score
@riverpod
int maxReportedExperianScore(MaxReportedExperianScoreRef ref) {
  final reports = ref.watch(getSortedExperianReportsProvider());
  final sorted = reports.sortedBy(compare: (a, b) => a.score.compareTo(b.score));

  return sorted.lastOrNull?.score ?? _kMaxCreditScore;
}

/// Calculates the score difference between the latest and previous Experian reports.
/// 
/// This provider computes the change in credit score from the most recent report
/// to the one before it, returning a positive number for improvements and negative
/// for decreases. This is used throughout the UI to show score trends and changes.
/// 
/// The calculation is: (latest score) - (previous score)
/// 
/// Returns 0 if there's insufficient historical data (less than 2 reports).
/// 
/// Example usage:
/// ```dart
/// final scoreDiff = ref.watch(latestExperianScoreDiffProvider);
/// 
/// if (scoreDiff > 0) {
///   print('Score improved by $scoreDiff points');
/// } else if (scoreDiff < 0) {
///   print('Score decreased by ${scoreDiff.abs()} points');
/// } else {
///   print('No change in score');
/// }
/// ```
/// 
/// This value is commonly displayed with visual indicators:
/// * Positive changes: Green pill with "+" prefix
/// * Negative changes: Red pill with "-" prefix  
/// * Zero changes: Neutral styling
/// 
/// See also:
/// * [ScoreDiffWidget] for UI display of score changes
/// * [latestExperianReportProvider] for current score details
@riverpod
int latestExperianScoreDiff(LatestExperianScoreDiffRef ref) {
  final reports =
      ref.watch(getSortedExperianReportsProvider(ascending: false, limit: 2));

  if (reports.length < 2) {
    return 0;
  }

  final latest = reports[0];
  final previous = reports[1];

  return latest.score - previous.score;
}
