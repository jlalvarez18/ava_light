import 'package:money2/money2.dart';

class AppConfig {
  static Currency currency =
      CommonCurrencies().usd.copyWith(pattern: "S#,###.00");
}
