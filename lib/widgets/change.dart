import 'package:crypto_track/model/crypto.dart';
import 'package:crypto_track/model/crypto_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

//TODO: create file for this class
class FiatCurrency {
  String name;
  String diminutive;
  String logoUrl;

  FiatCurrency({this.name, this.diminutive, this.logoUrl});
}

class ChangeWidget extends StatefulWidget {
  @override
  _ChangeWidgetState createState() => _ChangeWidgetState();
}

class _ChangeWidgetState extends State<ChangeWidget> {
  Crypto selectedCrypto;
  FiatCurrency selectedFiat;
  List<FiatCurrency> fiats = [
    FiatCurrency(name: "US Dollar", diminutive: "USD", logoUrl: "N/A"),
    FiatCurrency(name: "British Pound", diminutive: "GBP", logoUrl: "N/A"),
    FiatCurrency(name: "Euro", diminutive: "EUR", logoUrl: "N/A"),
    FiatCurrency(name: "Canadian Dollar", diminutive: "CAD", logoUrl: "N/A"),
    FiatCurrency(name: "Australian Dollar", diminutive: "AUD", logoUrl: "N/A"),
    FiatCurrency(name: "Hong Kong Dollar", diminutive: "HKD", logoUrl: "N/A"),
    FiatCurrency(name: "Swiss Franc", diminutive: "CHF", logoUrl: "N/A"),
    FiatCurrency(name: "Russian Ruble", diminutive: "RUB", logoUrl: "N/A"),
  ];

  TextEditingController _leftTextController = TextEditingController();
  TextEditingController _rightTextController = TextEditingController();

  void _buildCryptoModal(BuildContext context) {
    selectedCrypto = (selectedCrypto == null)
        ? Provider.of<CryptoList>(context, listen: false).getAtIndex(0)
        : selectedCrypto; //TODO: Init correctly

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      "Select a cryptocurrency",
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Expanded(
                  child: Consumer<CryptoList>(
                    builder: (context, value, child) {
                      return ListView.separated(
                        itemCount:
                            Provider.of<CryptoList>(context, listen: false)
                                .getLength(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 4.0),
                            child: ListTile(
                              onTap: () {
                                print(value.getAtIndex(index).name);
                                setState(() {
                                  selectedCrypto = value.getAtIndex(index);
                                });
                                Navigator.of(context).pop();
                              },
                              title: Text(
                                value.getAtIndex(index).name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[300],
                                ),
                              ),
                              subtitle: Text(
                                value.getAtIndex(index).diminutive,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[400],
                                ),
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    value.getAtIndex(index).logoUrl),
                                backgroundColor: Colors.transparent,
                              ),
                              trailing: (selectedCrypto.name ==
                                          value.getAtIndex(index).name &&
                                      selectedCrypto.diminutive ==
                                          value.getAtIndex(index).diminutive)
                                  ? Icon(Icons.check)
                                  : SizedBox(),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey[200],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _buildFiatModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      "Select a fiat",
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: fiats.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 4.0),
                        child: ListTile(
                          onTap: () {
                            print(fiats[index].name);
                            setState(() {
                              selectedFiat = fiats[index];
                            });
                            Navigator.of(context).pop();
                          },
                          title: Text(
                            fiats[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[300],
                            ),
                          ),
                          subtitle: Text(
                            fiats[index].diminutive,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400],
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(fiats[index].logoUrl),
                            backgroundColor: Colors.transparent,
                          ),
                          trailing: (selectedFiat.name == fiats[index].name &&
                                  selectedFiat.diminutive ==
                                      fiats[index].diminutive)
                              ? Icon(Icons.check)
                              : SizedBox(),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey[200],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<String> getData(bool side) async {
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
        return (double.parse(_rightTextController.value.text) / priceForOne)
            .toStringAsFixed(8);
      } else {
        // Left side -> crypto to fiat
        return (double.parse(_leftTextController.value.text) * priceForOne)
            .toStringAsFixed(2);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return "N/A";
    }
  }

  @override
  Widget build(BuildContext context) {
    selectedFiat = (selectedFiat == null) ? fiats[0] : selectedFiat;

    return Container(
      color: Colors.grey[900],
      child: Padding(
        padding: EdgeInsets.fromLTRB(55.0, 20.0, 55.0, 20.0),
        child: Container(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // =====================
                  // ==== LEFT COLUMN ====
                  // =====================
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.amberAccent[400],
                        ),
                        color: Colors.amberAccent[400],
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            height: 50.0,
                            child: RaisedButton(
                              onPressed: () {
                                _buildCryptoModal(context);
                              },
                              textColor: Colors.grey[900],
                              color: Colors.amberAccent[400],
                              child: Container(
                                child: Text(
                                  (selectedCrypto == null)
                                      ? "N/A"
                                      : selectedCrypto.diminutive.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _leftTextController,
                            onChanged: (value) async {
                              // await getData(true);
                              _rightTextController.value = TextEditingValue(
                                  text: await getData(false),
                                  selection: TextSelection.fromPosition(
                                      TextPosition(offset: value.length)));
                            },
                            cursorColor: Colors.amberAccent[400],
                            cursorWidth: 1.5,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: Colors.amberAccent[400],
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              fillColor: Colors.grey[900],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // =======================
                  // ==== MIDDLE COLUMN ====
                  // =======================
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.swap_horiz,
                          size: 40.0,
                          color: Colors.amberAccent[400],
                        ),
                      ],
                    ),
                  ),
                  // ======================
                  // ==== RIGHT COLUMN ====
                  // ======================
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.amberAccent[400],
                        ),
                        color: Colors.amberAccent[400],
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            height: 50.0,
                            child: RaisedButton(
                              onPressed: () {
                                _buildFiatModal(context);
                              },
                              textColor: Colors.grey[900],
                              color: Colors.amberAccent[400],
                              child: Container(
                                child: Text(
                                  selectedFiat.diminutive.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _rightTextController,
                            onChanged: (value) async {
                              _leftTextController.value = TextEditingValue(
                                  text: await getData(true),
                                  selection: TextSelection.fromPosition(
                                      TextPosition(offset: value.length)));
                            },
                            cursorColor: Colors.amberAccent[400],
                            cursorWidth: 1.5,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: Colors.amberAccent[400],
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              fillColor: Colors.grey[900],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
