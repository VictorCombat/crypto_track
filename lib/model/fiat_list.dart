import 'package:crypto_track/model/fiat.dart';
import 'package:flutter/cupertino.dart';

class FiatList extends ChangeNotifier {
  List<Fiat> fiats = [
    Fiat(
        name: "US Dollar",
        diminutive: "USD",
        logoUrl: "https://www.countryflags.io/us/flat/64.png"),
    Fiat(
        name: "British Pound",
        diminutive: "GBP",
        logoUrl: "https://www.countryflags.io/gb/flat/64.png"),
    Fiat(
        name: "Euro",
        diminutive: "EUR",
        logoUrl: "https://www.countryflags.io/eu/flat/64.png"),
    Fiat(
        name: "Canadian Dollar",
        diminutive: "CAD",
        logoUrl: "https://www.countryflags.io/ca/flat/64.png"),
    Fiat(
        name: "Australian Dollar",
        diminutive: "AUD",
        logoUrl: "https://www.countryflags.io/au/flat/64.png"),
    Fiat(
        name: "Hong Kong Dollar",
        diminutive: "HKD",
        logoUrl: "https://www.countryflags.io/hk/flat/64.png"),
    Fiat(
        name: "Swiss Franc",
        diminutive: "CHF",
        logoUrl: "https://www.countryflags.io/ch/flat/64.png"),
    Fiat(
        name: "Russian Ruble",
        diminutive: "RUB",
        logoUrl: "https://www.countryflags.io/ru/flat/64.png"),
  ];
}
