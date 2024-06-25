// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAllAccountsHash() => r'c13aa65bc936f8d036c234c21aab28ff5ac2a084';

/// See also [getAllAccounts].
@ProviderFor(getAllAccounts)
final getAllAccountsProvider = AutoDisposeProvider<List<Account>>.internal(
  getAllAccounts,
  name: r'getAllAccountsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAllAccountsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllAccountsRef = AutoDisposeProviderRef<List<Account>>;
String _$totalAccountBalanceHash() =>
    r'4db40429cb2f34bff330114924d9c68997343608';

/// See also [totalAccountBalance].
@ProviderFor(totalAccountBalance)
final totalAccountBalanceProvider = AutoDisposeProvider<Money>.internal(
  totalAccountBalance,
  name: r'totalAccountBalanceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalAccountBalanceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TotalAccountBalanceRef = AutoDisposeProviderRef<Money>;
String _$totalAccountLimitHash() => r'1890bf32570adb3ae068a8ac05c476c9f6a4d52a';

/// See also [totalAccountLimit].
@ProviderFor(totalAccountLimit)
final totalAccountLimitProvider = AutoDisposeProvider<Money>.internal(
  totalAccountLimit,
  name: r'totalAccountLimitProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalAccountLimitHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TotalAccountLimitRef = AutoDisposeProviderRef<Money>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
