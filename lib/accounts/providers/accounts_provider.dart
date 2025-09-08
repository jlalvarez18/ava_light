import 'package:ava_light/accounts/models/account.dart';
import 'package:ava_light/core/app_config.dart';
import 'package:ava_light/utilization/models/credit_utilization_report.dart';
import 'package:money2/money2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts_provider.g.dart';

/// Provides a collection of all credit card accounts in the user's portfolio.
/// 
/// This provider returns sample credit card account data representing a typical
/// user's credit portfolio with accounts from major financial institutions.
/// Each account includes balance, limit, dates, and computed utilization metrics.
/// 
/// The sample data demonstrates:
/// * Different credit limits and balances across cards
/// * Various utilization percentages (low, medium, high)
/// * Real-world card names from major issuers
/// * Recent reporting dates for data freshness
/// 
/// Example usage:
/// ```dart
/// final accounts = ref.watch(getAllAccountsProvider);
/// final totalCards = accounts.length;
/// final highUtilization = accounts.where((a) => a.usagePercentage > 0.3);
/// 
/// print('Total cards: $totalCards');
/// print('High utilization cards: ${highUtilization.length}');
/// ```
/// 
/// See also:
/// * [totalAccountBalanceProvider] for combined balance across all accounts
/// * [totalAccountLimitProvider] for combined credit limit
/// * [creditUtilizationReportProvider] for overall utilization analysis
@riverpod
List<Account> getAllAccounts(GetAllAccountsRef ref) {
  return [
    Account(
      uid: "Amazon Credit Card",
      dateAdded: DateTime(2023, 6, 20),
      name: "Amazon Credit Card",
      balanceInCents: 120000,
      limitInCents: 900000,
      dateLastReported: DateTime(2024, 6, 24),
    ),
    Account(
      uid: "Capital One Quicksilver",
      dateAdded: DateTime(2023, 6, 21),
      name: "Capital One Quicksilver",
      balanceInCents: 200000,
      limitInCents: 1000000,
      dateLastReported: DateTime(2024, 6, 24),
    ),
    Account(
      uid: "Apple Card",
      dateAdded: DateTime(2023, 6, 23),
      name: "Apple Card",
      balanceInCents: 200000,
      limitInCents: 500000,
      dateLastReported: DateTime(2024, 6, 24),
    ),
  ];
}

/// Calculates the total outstanding balance across all credit card accounts.
/// 
/// This provider sums the current balances of all accounts in the user's
/// portfolio, returning the result as a formatted [Money] object for display.
/// 
/// The calculation is performed in cents to maintain precision, then converted
/// to the app's configured currency format for consistent presentation.
/// 
/// Example usage:
/// ```dart
/// final totalBalance = ref.watch(totalAccountBalanceProvider);
/// print('Total debt: ${totalBalance.toString()}'); // e.g., "$5,200.00"
/// 
/// // For calculations, access the underlying amount
/// final balanceInCents = totalBalance.minorUnits; // 520000 cents
/// ```
/// 
/// This value is used in:
/// * Credit utilization calculations
/// * Financial summaries and dashboards
/// * Debt-to-limit ratio analysis
/// 
/// See also:
/// * [totalAccountLimitProvider] for combined credit limits
/// * [creditUtilizationReportProvider] for utilization analysis
@riverpod
Money totalAccountBalance(TotalAccountBalanceRef ref) {
  final accounts = ref.watch(getAllAccountsProvider);

  int total = accounts.fold(
    0,
    (previousValue, account) => previousValue + account.balanceInCents,
  );

  return Money.fromIntWithCurrency(total, AppConfig.currency);
}

/// Calculates the total credit limit across all credit card accounts.
/// 
/// This provider sums the credit limits of all accounts in the user's
/// portfolio, returning the result as a formatted [Money] object for display.
/// 
/// The total credit limit represents the maximum amount that can be charged
/// across all accounts and is essential for utilization calculations.
/// 
/// Example usage:
/// ```dart
/// final totalLimit = ref.watch(totalAccountLimitProvider);
/// print('Total available credit: ${totalLimit.toString()}'); // e.g., "$24,000.00"
/// 
/// // Calculate overall utilization
/// final balance = ref.watch(totalAccountBalanceProvider);
/// final utilizationRatio = balance.minorUnits / totalLimit.minorUnits;
/// ```
/// 
/// This value is used in:
/// * Credit utilization ratio calculations
/// * Available credit displays
/// * Credit health assessments
/// 
/// See also:
/// * [totalAccountBalanceProvider] for combined outstanding balances
/// * [creditUtilizationReportProvider] for detailed utilization analysis
@riverpod
Money totalAccountLimit(TotalAccountLimitRef ref) {
  final accounts = ref.watch(getAllAccountsProvider);

  int total = accounts.fold(
    0,
    (previousValue, account) => previousValue + account.limitInCents,
  );

  return Money.fromIntWithCurrency(total, AppConfig.currency);
}

@riverpod
CreditUtilizationReport creditUtilizationReport(
    CreditUtilizationReportRef ref) {
  final balance = ref.watch(totalAccountBalanceProvider);
  final limit = ref.watch(totalAccountLimitProvider);

  final ratio = balance.minorUnits / limit.minorUnits;

  return CreditUtilizationReport(ratio: ratio);
}
