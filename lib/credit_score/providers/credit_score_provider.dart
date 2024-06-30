import 'package:ava_light/core/extensions/list_extensions.dart';
import 'package:ava_light/credit_score/models/credit_score.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'credit_score_provider.g.dart';

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

@riverpod
List<CreditReport> getSortedExperianReports(GetSortedExperianReportsRef ref,
    {bool ascending = true}) {
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

  return sorted;
}

@riverpod
CreditReport latestExperianReport(LatestExperianReportRef ref) {
  final reports = ref.watch(getSortedExperianReportsProvider(ascending: false));

  return reports[0];
}

// source: https://www.capitalone.com/learn-grow/money-management/lowest-credit-score/
int _kMaxCreditScore = 850;
int _kMinCreditScore = 300;

@riverpod
int minReportedExperianScore(MinReportedExperianScoreRef ref) {
  final reports = ref.watch(getSortedExperianReportsProvider());

  final sorted =
      reports.sortedBy(compare: (a, b) => a.score.compareTo(b.score));

  return sorted.firstOrNull?.score ?? _kMinCreditScore;
}

@riverpod
int maxReportedExperianScore(MaxReportedExperianScoreRef ref) {
  final reports = ref.watch(getSortedExperianReportsProvider());

  final sorted =
      reports.sortedBy(compare: (a, b) => a.score.compareTo(b.score));

  return sorted.lastOrNull?.score ?? _kMaxCreditScore;
}
