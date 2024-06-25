import 'package:ava_light/core/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:money2/money2.dart';

@immutable
final class Account {
  final String uid;
  final DateTime dateAdded;
  final String name;
  final int balanceInCents;
  final int limitInCents;
  final DateTime dateLastReported;

  Account({
    required this.uid,
    required this.dateAdded,
    required this.name,
    required this.balanceInCents,
    required this.limitInCents,
    required this.dateLastReported,
  });

  Money get balance {
    return Money.fromIntWithCurrency(balanceInCents, AppConfig.currency);
  }

  Money get limit {
    return Money.fromIntWithCurrency(limitInCents, AppConfig.currency);
  }

  double get usagePercentage {
    return balanceInCents / limitInCents;
  }
}
