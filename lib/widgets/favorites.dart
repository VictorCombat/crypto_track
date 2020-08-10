import 'package:crypto_track/model/crypto.dart';
import 'package:flutter/material.dart';

class FavoritesWidget extends StatefulWidget {
  @override
  _FavoritesWidgetState createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  List<Crypto> favCryptos = [
    Crypto(name: 'Bitcoin', diminutive: 'BTC', price: '3000'),
    Crypto(name: 'Elrond', diminutive: 'ERD', price: '0,0243'),
    Crypto(name: 'Crypto.com Coin', diminutive: 'CRO', price: '0,001756'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'FAVORITES',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        ListView.builder(
          itemCount: favCryptos.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 14.0),
              child: Card(
                color: Colors.indigo[900],
                child: ListTile(
                  onTap: () {},
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        favCryptos[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.grey[300],
                        ),
                      ),
                      Text(
                        favCryptos[index].diminutive,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  leading: Icon(Icons.add_comment),
                ),
              ),
            );
          },
        ),
        FlatButton(
          onPressed: () {},
          child: Text('+ Add a favorite'),
        ),
      ],
    );
  }
}
