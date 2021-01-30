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
        title: Text(
          'CryptoTrack',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            print('SETTINGS BUTTON CLICKED');
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
      ),
      body:
          // Column(
          //   children: [
          //     Container(
          //       height: MediaQuery.of(context).size.height * 0.3,
          //       color: Colors.amberAccent[400],
          //     ),
          //     Container(
          //       width: MediaQuery.of(context).size.width * 0.8,
          //       transform: Matrix4.translationValues(0.0, -50.0, 0.0),
          //       child: FavoritesWidget(),
          //     ),
          //   ],
          // ),

          Scrollbar(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ChangeWidget(),
                    FavoritesWidget(),
                    TopCoinsWidget(),
                    SizedBox(
                      height: 40.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
