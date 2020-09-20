import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

enum HistoricalDataType {
  eight_hour,
  one_day,
  one_week,
  one_month,
  six_month,
}

class Crypto {
  String name; // name of the currency (ex: Bitcoin)
  String diminutive; // diminutive of the currency (ex: BTC)
  String price; // price of the currency
  String change;
  String changeValue;
  String logoUrl;

  HistoricalData historicalData = HistoricalData();

  Crypto(
      {this.name,
      this.diminutive,
      this.price,
      this.change,
      this.changeValue,
      this.logoUrl});

  Future<bool> getHistoricalData(HistoricalDataType type) async {
    print('[TYPE]: ${type.toString()}');

    // Get timestamp correctly
    String to = (DateTime.now().toUtc().millisecondsSinceEpoch / 1000)
        .round()
        .toString();

    String from = 'N/A';

    switch (type) {
      case HistoricalDataType.eight_hour:
        from = (DateTime.now()
                    .subtract(Duration(hours: 8))
                    .toUtc()
                    .millisecondsSinceEpoch /
                1000)
            .round()
            .toString();
        break;
      case HistoricalDataType.one_day:
        from = (DateTime.now()
                    .subtract(Duration(days: 1))
                    .toUtc()
                    .millisecondsSinceEpoch /
                1000)
            .round()
            .toString();
        break;
      case HistoricalDataType.one_week:
        from = (DateTime.now()
                    .subtract(Duration(days: 7))
                    .toUtc()
                    .millisecondsSinceEpoch /
                1000)
            .round()
            .toString();
        break;
      case HistoricalDataType.one_month:
        from = (DateTime.now()
                    .subtract(Duration(days: 30))
                    .toUtc()
                    .millisecondsSinceEpoch /
                1000)
            .round()
            .toString();
        break;
      case HistoricalDataType.six_month:
        from = (DateTime.now()
                    .subtract(Duration(days: 180))
                    .toUtc()
                    .millisecondsSinceEpoch /
                1000)
            .round()
            .toString();
        break;
    }

    // Construct the request
    var url =
        'https://api.coingecko.com/api/v3/coins/${name.toLowerCase()}/market_chart/range?vs_currency=eur&from=$from&to=$to';

    print('[HTTP REQUEST] : $url');
    print('------ -----');
    // Execute the request
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      historicalData.data.clear();
      jsonResponse['prices'].forEach((element) {
        historicalData.data.add(new Data(element[1].toString(),
            new DateTime.fromMillisecondsSinceEpoch(element[0])));
      });

      print('[HTTP REQUEST DONE]');
      return Future.value(true);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}

class HistoricalData {
  List<Data> data = [];
}

class Data {
  String price;
  DateTime date;

  Data(this.price, this.date);
}
