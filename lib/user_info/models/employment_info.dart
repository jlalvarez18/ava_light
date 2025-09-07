import 'package:money2/money2.dart';

final class EmploymentInfo {
  final EmploymentType type;
  final String employerName;
  final String jobTitle;
  final Money grossAnnualIncome;
  final PayFrequency frequency;
  final DateTime nextPayDate;
  final bool isDirectDeposit;
  final String employerAddress;
  final int monthsEmployed;

  EmploymentInfo({
    required this.type,
    required this.employerName,
    required this.jobTitle,
    required this.grossAnnualIncome,
    required this.frequency,
    required this.nextPayDate,
    required this.isDirectDeposit,
    required this.employerAddress,
    required this.monthsEmployed,
  });
}

enum EmploymentType {
  fullTime,
  partTime,
  contract,
  selfEmployed,
  unemployed;

  String get stringValue {
    switch (this) {
      case EmploymentType.fullTime:
        return "Full-time";
      case EmploymentType.partTime:
        return "Part-time";
      case EmploymentType.contract:
        return "Contract";
      case EmploymentType.selfEmployed:
        return "Self Employed";
      case EmploymentType.unemployed:
        return "Unemployed";
    }
  }
}

enum PayFrequency {
  biWeekly,
  semiWeekly,
  monthly;

  String get stringValue {
    switch (this) {
      case PayFrequency.biWeekly:
        return "Bi-Weekly";
      case PayFrequency.semiWeekly:
        return "Semi-Weekly";
      case PayFrequency.monthly:
        return "Monthly";
    }
  }
}
