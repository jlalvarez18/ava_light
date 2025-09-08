import 'package:ava_light/core/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:money2/money2.dart';

/// Represents a credit card account with balance, limit, and usage information.
/// 
/// This immutable data class encapsulates all essential account information
/// including financial details, dates, and computed metrics like usage percentage.
/// 
/// Financial amounts are stored in cents to avoid floating-point precision
/// issues when performing calculations. The [Money] class from the money2
/// package is used for display and formatting.
/// 
/// Usage percentage is automatically calculated as balance ÷ limit, providing
/// a normalized value between 0.0 and 1.0 for credit utilization analysis.
/// 
/// Example:
/// ```dart
/// final account = Account(
///   uid: 'chase-freedom-001',
///   dateAdded: DateTime(2023, 1, 15),
///   name: 'Chase Freedom Unlimited',
///   balanceInCents: 125000,  // $1,250.00
///   limitInCents: 500000,    // $5,000.00
///   dateLastReported: DateTime(2024, 6, 1),
/// );
/// 
/// print(account.balance);         // $1,250.00
/// print(account.usagePercentage); // 0.25 (25%)
/// ```
/// 
/// See also:
/// * [AppConfig.currency] for currency formatting configuration
@immutable
final class Account {
  /// Unique identifier for this account.
  /// 
  /// Used for widget keys, data persistence, and distinguishing between
  /// multiple accounts in collections.
  final String uid;
  
  /// The date when this account was first added to the system.
  final DateTime dateAdded;
  
  /// Human-readable name or description of the account.
  /// 
  /// Typically includes the bank name and card type (e.g., "Chase Freedom Unlimited").
  final String name;
  
  /// Current outstanding balance in cents.
  /// 
  /// Stored as an integer to avoid floating-point precision issues.
  /// Use [balance] getter to get the formatted [Money] representation.
  final int balanceInCents;
  
  /// Credit limit in cents.
  /// 
  /// The maximum amount that can be charged to this account.
  /// Stored as an integer to avoid floating-point precision issues.
  /// Use [limit] getter to get the formatted [Money] representation.
  final int limitInCents;
  
  /// The date when this account information was last reported by the creditor.
  final DateTime dateLastReported;

  /// Creates a new account instance.
  /// 
  /// All parameters are required:
  /// * [uid] - Unique identifier for the account
  /// * [dateAdded] - When the account was added to tracking
  /// * [name] - Display name for the account
  /// * [balanceInCents] - Current balance in cents (integer)
  /// * [limitInCents] - Credit limit in cents (integer)
  /// * [dateLastReported] - When the data was last updated
  Account({
    required this.uid,
    required this.dateAdded,
    required this.name,
    required this.balanceInCents,
    required this.limitInCents,
    required this.dateLastReported,
  });

  /// The current account balance as a formatted [Money] object.
  /// 
  /// Converts the internal cents-based storage to a user-friendly
  /// currency representation using the app's configured currency format.
  /// 
  /// Example:
  /// ```dart
  /// final account = Account(balanceInCents: 125000, ...);
  /// print(account.balance.toString()); // "$1,250.00"
  /// ```
  Money get balance {
    return Money.fromIntWithCurrency(balanceInCents, AppConfig.currency);
  }

  /// The credit limit as a formatted [Money] object.
  /// 
  /// Converts the internal cents-based storage to a user-friendly
  /// currency representation using the app's configured currency format.
  /// 
  /// Example:
  /// ```dart
  /// final account = Account(limitInCents: 500000, ...);
  /// print(account.limit.toString()); // "$5,000.00"
  /// ```
  Money get limit {
    return Money.fromIntWithCurrency(limitInCents, AppConfig.currency);
  }

  /// Calculates the credit utilization percentage as a decimal (0.0 to 1.0).
  /// 
  /// Credit utilization is calculated as: current balance ÷ credit limit
  /// 
  /// This value is used throughout the app for:
  /// * Progress indicators and visualizations
  /// * Credit score impact analysis
  /// * Financial health assessments
  /// 
  /// Example:
  /// ```dart
  /// final account = Account(
  ///   balanceInCents: 150000,  // $1,500
  ///   limitInCents: 500000,    // $5,000
  ///   ...
  /// );
  /// print(account.usagePercentage); // 0.30 (30% utilization)
  /// ```
  /// 
  /// Note: Lower utilization percentages generally have a positive impact
  /// on credit scores, with recommendations typically under 30%.
  double get usagePercentage {
    return balanceInCents / limitInCents;
  }
}
