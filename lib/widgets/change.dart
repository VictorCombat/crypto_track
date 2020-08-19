import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
