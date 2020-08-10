import 'package:flutter/material.dart';

class ChangeWidget extends StatefulWidget {
  @override
  _ChangeWidgetState createState() => _ChangeWidgetState();
}

class _ChangeWidgetState extends State<ChangeWidget> {
  List<String> cryptos = ['BTC', 'ETH', 'MCO'];
  List<String> fiats = ['USD', 'EUR', 'GBP'];
  String selectedCrypto;
  String selectedFiat;

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        /* ==== LEFT COLUMN ==== */
        Column(
          children: <Widget>[
            DropdownButton<String>(
              value: selectedCrypto,
              onChanged: (String value) {
                setState(() {
                  selectedCrypto = value;
                });
              },
              items: cryptos.map((String crypto) {
                return DropdownMenuItem<String>(
                  value: crypto,
                  child: Text(crypto),
                );
              }).toList(),
            ),
          ],
        ),
        /* ==== MIDDLE COLUMN ==== */
        Column(
          children: <Widget>[
            Icon(Icons.arrow_forward),
          ],
        ),
        /* ==== RIGHT COLUMN ==== */
        Column(
          children: <Widget>[
            DropdownButton<String>(
              value: selectedFiat,
              onChanged: (String value) {
                setState(() {
                  selectedFiat = value;
                });
              },
              items: fiats.map((String fiat) {
                return DropdownMenuItem<String>(
                  value: fiat,
                  child: Text(fiat),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }
}
