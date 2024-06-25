import 'package:ava_light/credit_score/models/credit_score.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'credit_score_provider.g.dart';

@riverpod
List<CreditReport> getExperianReports(GetExperianReportsRef ref) {
  return [
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
      score: 600,
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
}

int _kMaxCreditScore = 850;
int _kMinCreditScore = 850;

@riverpod
int minExperianScore(MinExperianScoreRef ref) {
  final reports = ref.watch(getExperianReportsProvider);

  reports.sort();

  return reports.firstOrNull?.score ?? _kMinCreditScore;
}

@riverpod
int maxExperianScore(MaxExperianScoreRef ref) {
  final reports = ref.watch(getExperianReportsProvider);

  reports.sort();

  return reports.lastOrNull?.score ?? _kMaxCreditScore;
}
