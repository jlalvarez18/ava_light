import 'package:ava_light/credit_factors/models/credit_factor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'credit_factors_provider.g.dart';

@riverpod
List<CreditFactor> allCreditFactors(AllCreditFactorsRef ref) {
  return [
    CreditFactor(
      title: "Payment History",
      value: "100%",
      impact: CreditImpact.high,
    ),
    CreditFactor(
      title: "Credit Card Utilization",
      value: "4%",
      impact: CreditImpact.low,
    ),
    CreditFactor(
      title: "Deragatory Marks",
      value: "2",
      impact: CreditImpact.medium,
    ),
    CreditFactor(
      title: "Age of Credit History",
      value: "1yr 4mo",
      impact: CreditImpact.low,
    ),
    CreditFactor(
      title: "Hard Inquiries",
      value: "3",
      impact: CreditImpact.medium,
    ),
    CreditFactor(
      title: "Total Accounts",
      value: "9",
      impact: CreditImpact.medium,
    ),
  ];
}
