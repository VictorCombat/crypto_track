import 'package:crypto_track/model/crypto.dart';
import 'package:flutter/material.dart';
import 'package:drag_list/drag_list.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Crypto> favCryptos = [
    Crypto(
        name: 'Bitcoin',
        diminutive: 'BTC',
        price: '3000',
        change: '-',
        changeValue: '3,25'),
    Crypto(
        name: 'Elrond',
        diminutive: 'ERD',
        price: '0,0243',
        change: '+',
        changeValue: '14,03'),
    Crypto(
        name: 'Crypto.com Coin',
        diminutive: 'CRO',
        price: '0,001756',
        change: '+',
        changeValue: '28,92'),
  ];
  String currencySetting = '€';
  Color changeColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text(
            'FAVORITES',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          elevation: 0.0,
        ),
        body: DragList<Crypto>(
            items: favCryptos,
            itemExtent: 72.0,
            handleBuilder: (context) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Icon(
                    Icons.menu,
                    color: Colors.grey[300],
                  ),
                ),
              );
            },
            feedbackItemBuilder: (context, item, handle, transition) {
              return Container(
                height: 72.0,
                color: Colors.grey[700],
                child: Container(
                  height: 72.0,
                  child: Row(
                    children: <Widget>[
                      handle,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.value.name,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[300],
                            ),
                          ),
                          Text(
                            item.value.diminutive,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            itemBuilder: (context, item, handle) {
              changeColor = (item.value.change == '+')
                  ? Colors.greenAccent[700]
                  : Colors.redAccent[700];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.amberAccent[400])),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(flex: 1, child: handle),
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.value.name,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[300],
                              ),
                            ),
                            Text(
                              item.value.diminutive,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              item.value.price + currencySetting,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[300],
                              ),
                            ),
                            Text(
                              item.value.change +
                                  ' ' +
                                  item.value.changeValue +
                                  '%',
                              style: TextStyle(
                                color: changeColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
