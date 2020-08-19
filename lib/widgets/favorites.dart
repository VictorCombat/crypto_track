import 'package:crypto_track/model/crypto_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesWidget extends StatefulWidget {
  @override
  _FavoritesWidgetState createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  String currencySetting = '€';
  Color changeColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          child: Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              border: Border(
                bottom: BorderSide(
                  width: 2.0,
                  color: Colors.grey[850],
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.star,
                  color: Colors.amberAccent[400],
                ),
                SizedBox(width: 10.0),
                Text(
                  'FAVORITES',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent[400],
                  ),
                ),
                SizedBox(width: 10.0),
                Icon(
                  Icons.star,
                  color: Colors.amberAccent[400],
                ),
              ],
            ),
          ),
        ),
        Consumer<CryptoList>(builder: (context, value, child) {
          return Column(
            children: value.favCryptos.map((crypto) {
              if (value.favCryptos.indexOf(crypto) < 4) {
                changeColor = (crypto.changeValue == null)
                    ? Colors.grey[400]
                    : (crypto.changeValue >= 0)
                        ? Colors.greenAccent[700]
                        : Colors.redAccent[700];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 12.0),
                  child: Container(
                    child: Card(
                      elevation: 20.0,
                      color: Colors.grey[850],
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/crypto_details',
                              arguments: crypto);
                        },
                        title: Text(
                          crypto.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[300],
                          ),
                        ),
                        subtitle: Text(
                          crypto.diminutive,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400],
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(crypto.logoUrl),
                          backgroundColor: Colors.transparent,
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              crypto.price.toStringAsFixed(2) + currencySetting,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[300],
                              ),
                            ),
                            Text(
                              crypto.change +
                                  ' ' +
                                  ((crypto.changeValue == null)
                                      ? 'N/A'.toString()
                                      : crypto.changeValue
                                          .abs()
                                          .toStringAsFixed(2)) +
                                  '%',
                              style: TextStyle(
                                color: changeColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  height: 0.0,
                  width: 0.0,
                );
              }
            }).toList(),
          );
        }),
        FlatButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/favorites');
          },
          child: Text(
            'See all favorites',
            style: TextStyle(
              color: Colors.grey[300],
            ),
          ),
        ),
      ],
    );
  }
}
