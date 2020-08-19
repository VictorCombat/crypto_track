import 'package:crypto_track/model/crypto.dart';
import 'package:crypto_track/model/crypto_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopCoinsWidget extends StatefulWidget {
  @override
  _TopCoinsWidgetState createState() => _TopCoinsWidgetState();
}

class _TopCoinsWidgetState extends State<TopCoinsWidget> {
  String currencySetting = '€';

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
                ImageIcon(
                  AssetImage('assets/fire.png'),
                  color: Colors.amberAccent[400],
                ),
                SizedBox(width: 10.0),
                Text(
                  'TOP COINS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent[400],
                  ),
                ),
                SizedBox(width: 10.0),
                ImageIcon(
                  AssetImage('assets/fire.png'),
                  color: Colors.amberAccent[400],
                ),
              ],
            ),
          ),
        ),
        Consumer<CryptoList>(builder: (context, value, child) {
          return Column(
            children: value.hotCryptos.map((crypto) {
              if (value.hotCryptos.indexOf(crypto) < 4) {
                return Container(
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
                              crypto.changeValue.abs().toStringAsFixed(2) +
                              '%',
                          style: TextStyle(
                            color: Colors.greenAccent[700],
                          ),
                        ),
                      ],
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
      ],
    );
  }
}
