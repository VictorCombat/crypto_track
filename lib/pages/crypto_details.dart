import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crypto_track/model/crypto.dart';
import 'package:crypto_track/model/crypto_list.dart';

class CryptoDetails extends StatefulWidget {
  @override
  _CryptoDetailsState createState() => _CryptoDetailsState();
}

class _CryptoDetailsState extends State<CryptoDetails> {
  Crypto crypto;

  @override
  Widget build(BuildContext context) {
    crypto =
        crypto != null ? crypto : ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(crypto.name),
        actions: [
          Consumer<CryptoList>(
            builder: (context, value, child) {
              return IconButton(
                icon: value.favCryptos.contains(crypto)
                    ? Icon(Icons.star)
                    : Icon(Icons.star_border),
                onPressed: () {
                  if (value.favCryptos.contains(crypto)) {
                    value.removeFavoriteByName(crypto.name);
                  } else {
                    value.addFavoriteByName(crypto.name);
                  }
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              print('TAP');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80.0,
          ),
          Center(
            child: Text(
              'CHART',
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 80.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
