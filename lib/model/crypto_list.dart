import 'package:crypto_track/model/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CryptoList extends ChangeNotifier {
  List<Crypto> cryptos = [];
  List<Crypto> favCryptos = [];
  List<Crypto> hotCryptos = [];

  CryptoList() {
    _init();
  }

  _init() async {
    await getData();
    _read();
  }

  int getLength() {
    return cryptos.length;
  }

  Crypto getAtIndex(int index) {
    return (index < cryptos.length) ? cryptos[index] : null;
  }

  void getData() async {
    var url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=false';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      jsonResponse.forEach((element) {
        cryptos.add(new Crypto(
          name: element['name'],
          diminutive: element['symbol'].toString().toUpperCase(),
          price: element['current_price'],
          logoUrl: element['image'],
          change: (element['price_change_percentage_24h'] == null)
              ? "N/A"
              : (element['price_change_percentage_24h'] >= 0) ? '+' : '-',
          changeValue: element['price_change_percentage_24h'] ?? null,
        ));
      });

      // print('------------ ------------');
      // cryptos.forEach((element) {
      //   print(
      //       '[${cryptos.indexOf(element)}] ${element.name}: \t\t\t ${element.changeValue}');
      // });
      // print('------------ ------------');

      /* ===== PROCESSING HOT CRYPTO GAINERS ===== */
      hotCryptos.addAll(cryptos);
      hotCryptos.sort((b, a) {
        if (b.changeValue == null || a.changeValue == null) return 1;
        return a.changeValue.compareTo(b.changeValue);
      });
      if (hotCryptos.length > 4) hotCryptos.removeRange(4, hotCryptos.length);
      // print('------------ ------------');
      // hotCryptos.forEach((element) {
      //   print(
      //       '[${hotCryptos.indexOf(element)}] ${element.name}: \t\t\t ${element.changeValue}');
      // });
      // print('------------ ------------');

      print('[GET DATA OK] -> notifyListeners()');

      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void addFavoriteByName(String name) {
    favCryptos.add(cryptos.firstWhere(
        (element) => element.name.toLowerCase().contains(name.toLowerCase())));

    notifyListeners();
    _save();
  }

  void removeFavoriteByName(String name) {
    favCryptos.remove(cryptos.firstWhere(
        (element) => element.name.toLowerCase().contains(name.toLowerCase())));

    notifyListeners();
    _save();
  }

  void swapFavoriteByIndex(int from, int to) {
    Crypto tmp = favCryptos[to];
    favCryptos[to] = favCryptos[from];
    favCryptos[from] = tmp;

    notifyListeners();
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'favorites';
    final value = prefs.getStringList(key);
    if (value.isNotEmpty) {
      value.forEach((element) {
        addFavoriteByName(element);
      });
    }
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'favorites';
    final List<String> value = [];
    favCryptos.forEach((element) {
      value.add(element.name);
    });
    prefs.setStringList(key, value);
  }
}
