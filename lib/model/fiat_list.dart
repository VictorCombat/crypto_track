import 'package:crypto_track/model/fiat.dart';
import 'package:flutter/cupertino.dart';

class FiatList extends ChangeNotifier {
  List<Fiat> fiats = [
    Fiat(name: "US Dollar", diminutive: "USD", logoUrl: "N/A"),
    Fiat(name: "British Pound", diminutive: "GBP", logoUrl: "N/A"),
    Fiat(name: "Euro", diminutive: "EUR", logoUrl: "N/A"),
    Fiat(name: "Canadian Dollar", diminutive: "CAD", logoUrl: "N/A"),
    Fiat(name: "Australian Dollar", diminutive: "AUD", logoUrl: "N/A"),
    Fiat(name: "Hong Kong Dollar", diminutive: "HKD", logoUrl: "N/A"),
    Fiat(name: "Swiss Franc", diminutive: "CHF", logoUrl: "N/A"),
    Fiat(name: "Russian Ruble", diminutive: "RUB", logoUrl: "N/A"),
  ];
}
