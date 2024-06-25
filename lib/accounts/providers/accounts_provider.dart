import 'package:ava_light/accounts/models/account.dart';
import 'package:ava_light/core/app_config.dart';
import 'package:money2/money2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts_provider.g.dart';

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

@riverpod
Money totalAccountBalance(TotalAccountBalanceRef ref) {
  final accounts = ref.watch(getAllAccountsProvider);

  int total = accounts.fold(
    0,
    (previousValue, account) => previousValue + account.balanceInCents,
  );

  return Money.fromIntWithCurrency(total, AppConfig.currency);
}

@riverpod
Money totalAccountLimit(TotalAccountLimitRef ref) {
  final accounts = ref.watch(getAllAccountsProvider);

  int total = accounts.fold(
    0,
    (previousValue, account) => previousValue + account.limitInCents,
  );

  return Money.fromIntWithCurrency(total, AppConfig.currency);
}
