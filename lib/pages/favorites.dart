import 'package:crypto_track/model/crypto.dart';
import 'package:crypto_track/model/crypto_list.dart';
import 'package:flutter/material.dart';
import 'package:drag_list/drag_list.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  String currencySetting = '€';
  Color changeColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          // title: Text(
          //   'My favorites coins',
          //   style: TextStyle(fontWeight: FontWeight.bold),
          // ),
          leading: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              print('settings');
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          elevation: 0.0,
        ),
        body: Consumer<CryptoList>(builder: (context, value, child) {
          return DragList<Crypto>(
              items: value.favCryptos,
              itemExtent: 72.0,
              onItemReorder: (from, to) {
                value.swapFavoriteByIndex(from, to);
              },
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
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/crypto_details',
                          arguments: item.value);
                    },
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
                                  item.value.price.toString() + currencySetting,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                Text(
                                  item.value.change +
                                      ' ' +
                                      ((item.value.changeValue == null)
                                          ? 'N/A'.toString()
                                          : double.parse(item.value.changeValue)
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
                        ],
                      ),
                    ),
                  ),
                );
              });
        }));
  }
}
