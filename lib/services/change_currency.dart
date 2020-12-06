import 'package:crypto_track/model/crypto.dart';
import 'package:crypto_track/model/fiat.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ChangeCurrency {
  static Future<String> change(
      bool side, Crypto selectedCrypto, Fiat selectedFiat, String value) async {
    // CALL API : "https://api.coingecko.com/api/v3/simple/price?ids=${selectedCrypto.name.toLowerCase()}&vs_currencies=${selectedFiat.diminutive.toLowerCase()}"
    var url =
        "https://api.coingecko.com/api/v3/simple/price?ids=${selectedCrypto.name.toLowerCase()}&vs_currencies=${selectedFiat.diminutive.toLowerCase()}";
    print("[-- CALL API --] : $url");

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      print("[-- RESPONSE --]: $jsonResponse");
      // print(jsonResponse['${selectedCrypto.name.toLowerCase()}']
      //         ['${selectedFiat.diminutive.toLowerCase()}']
      //     .runtimeType);

      // Get the price for one unit
      double priceForOne = jsonResponse['${selectedCrypto.name.toLowerCase()}']
          ['${selectedFiat.diminutive.toLowerCase()}'];

      if (side) {
        // Right side -> fiat to crypto
        return (double.parse(value) / priceForOne).toStringAsFixed(8);
      } else {
        // Left side -> crypto to fiat
        return (double.parse(value) * priceForOne).toStringAsFixed(2);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return "N/A";
    }
  }
}
