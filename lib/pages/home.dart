import 'package:crypto_track/widgets/change.dart';
import 'package:crypto_track/widgets/favorites.dart';
import 'package:crypto_track/widgets/top_coins.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            print('SETTINGS BUTTON CLICKED');
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ChangeWidget(),
                  FavoritesWidget(),
                  TopCoinsWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
