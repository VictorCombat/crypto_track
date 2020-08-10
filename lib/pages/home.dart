import 'package:crypto_track/main.dart';
import 'package:crypto_track/model/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Crypto> favCryptos = [
    Crypto(name: 'Bitcoin', diminutive: 'BTC', price: '3000'),
    Crypto(name: 'Elrond', diminutive: 'ERD', price: '0,0243'),
    Crypto(name: 'Crypto.com Coin', diminutive: 'CRO', price: '0,001756'),
  ];

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

class ChangeWidget extends StatefulWidget {
  @override
  _ChangeWidgetState createState() => _ChangeWidgetState();
}

class _ChangeWidgetState extends State<ChangeWidget> {
  List<String> cryptos = ['BTC', 'ETH', 'MCO'];
  List<String> fiats = ['USD', 'EUR', 'GBP'];
  String selectedCrypto;
  String selectedFiat;

  @override
  Widget build(BuildContext context) {
    selectedCrypto = cryptos[0];
    selectedFiat = fiats[0];

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
              // boxShadow: <BoxShadow>[
              //   BoxShadow(
              //     color: Colors.indigo[400],
              //     offset: Offset(0.0, 0.0),
              //     blurRadius: 1.0,
              //   ),
              // ],
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
                                print('RaisedButton pressed');
                              },
                              textColor: Colors.grey[900],
                              color: Colors.amberAccent[400],
                              child: Container(
                                child: Text(
                                  selectedCrypto,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
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
                          Icons.swap_horizontal_circle,
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
                                print('RaisedButton pressed');
                              },
                              textColor: Colors.grey[900],
                              color: Colors.amberAccent[400],
                              child: Container(
                                child: Text(
                                  selectedFiat,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
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

class FavoritesWidget extends StatefulWidget {
  @override
  _FavoritesWidgetState createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
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
    Crypto(
        name: 'Tezos',
        diminutive: 'XTZ',
        price: '2,85',
        change: '+',
        changeValue: '3,6'),
    Crypto(
        name: 'Ethereum',
        diminutive: 'ETH',
        price: '285',
        change: '-',
        changeValue: '10,0'),
  ];
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
        Column(
          children: favCryptos.map((crypto) {
            if (favCryptos.indexOf(crypto) < 4) {
              changeColor = (crypto.change == '+')
                  ? Colors.greenAccent[700]
                  : Colors.redAccent[700];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                child: Container(
                  child: Card(
                    elevation: 20.0,
                    color: Colors.grey[850],
                    child: ListTile(
                      onTap: () {
                        print('Tap on ${crypto.name}');
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
                      leading: Text(
                        'LOGO',
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            crypto.price + currencySetting,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[300],
                            ),
                          ),
                          Text(
                            crypto.change + ' ' + crypto.changeValue + '%',
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
        ),
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

class TopCoinsWidget extends StatefulWidget {
  @override
  _TopCoinsWidgetState createState() => _TopCoinsWidgetState();
}

class _TopCoinsWidgetState extends State<TopCoinsWidget> {
  List<Crypto> hotCryptos = [
    Crypto(
        name: 'Bitcoin',
        diminutive: 'BTC',
        price: '3000',
        change: '+',
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
    Crypto(
        name: 'Tezos',
        diminutive: 'XTZ',
        price: '2,85',
        change: '+',
        changeValue: '3,6'),
    Crypto(
        name: 'Ethereum',
        diminutive: 'ETH',
        price: '285',
        change: '+',
        changeValue: '10,0'),
  ];
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
        Column(
          children: hotCryptos.map((crypto) {
            if (hotCryptos.indexOf(crypto) < 4) {
              return Container(
                child: ListTile(
                  onTap: () {
                    print('Tap on ${crypto.name}');
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
                  leading: Text(
                    'LOGO',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        crypto.price + currencySetting,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[300],
                        ),
                      ),
                      Text(
                        crypto.change + ' ' + crypto.changeValue + '%',
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
        ),
      ],
    );
  }
}
