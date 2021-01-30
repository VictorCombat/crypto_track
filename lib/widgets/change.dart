import 'package:crypto_track/model/crypto.dart';
import 'package:crypto_track/model/crypto_list.dart';
import 'package:crypto_track/model/fiat.dart';
import 'package:crypto_track/model/fiat_list.dart';
import 'package:crypto_track/services/change_currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChangeWidget extends StatefulWidget {
  @override
  _ChangeWidgetState createState() => _ChangeWidgetState();
}

class _ChangeWidgetState extends State<ChangeWidget> {
  Crypto selectedCrypto;
  Fiat selectedFiat;

  TextEditingController _leftTextController = TextEditingController();
  TextEditingController _rightTextController = TextEditingController();

  //TODO: Generic way to build the modal

  void _buildCryptoModal(BuildContext context) {
    selectedCrypto = (selectedCrypto == null)
        ? Provider.of<CryptoList>(context, listen: false).getAtIndex(0)
        : selectedCrypto; //TODO: Init correctly

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Select a cryptocurrency",
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.grey[300],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Expanded(
                  child: Consumer<CryptoList>(
                    builder: (context, value, child) {
                      return ListView.separated(
                        itemCount:
                            Provider.of<CryptoList>(context, listen: false)
                                .getLength(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 4.0),
                            child: ListTile(
                              onTap: () {
                                print(value.getAtIndex(index).name);
                                setState(() {
                                  selectedCrypto = value.getAtIndex(index);
                                });
                                Navigator.of(context).pop();
                              },
                              title: Text(
                                value.getAtIndex(index).name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: (selectedCrypto.name ==
                                              value.getAtIndex(index).name &&
                                          selectedCrypto.diminutive ==
                                              value
                                                  .getAtIndex(index)
                                                  .diminutive)
                                      ? Colors.amberAccent[400]
                                      : Colors.grey[300],
                                ),
                              ),
                              subtitle: Text(
                                value.getAtIndex(index).diminutive,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: (selectedCrypto.name ==
                                              value.getAtIndex(index).name &&
                                          selectedCrypto.diminutive ==
                                              value
                                                  .getAtIndex(index)
                                                  .diminutive)
                                      ? Colors.amberAccent[400]
                                      : Colors.grey[400],
                                ),
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    value.getAtIndex(index).logoUrl),
                                backgroundColor: Colors.transparent,
                              ),
                              trailing: (selectedCrypto.name ==
                                          value.getAtIndex(index).name &&
                                      selectedCrypto.diminutive ==
                                          value.getAtIndex(index).diminutive)
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.amberAccent[400],
                                    )
                                  : SizedBox(),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey[200],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _buildFiatModal(BuildContext context) {
    selectedFiat = (selectedFiat == null)
        ? Provider.of<FiatList>(context, listen: false).fiats[0]
        : selectedFiat; //TODO: Init correctly

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Select a fiat currency",
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.grey[300],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: Provider.of<FiatList>(context).fiats.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 4.0),
                        child: ListTile(
                          onTap: () {
                            print(Provider.of<FiatList>(context, listen: false)
                                .fiats[index]
                                .name);
                            setState(() {
                              selectedFiat =
                                  Provider.of<FiatList>(context, listen: false)
                                      .fiats[index];
                            });
                            Navigator.of(context).pop();
                          },
                          title: Text(
                            Provider.of<FiatList>(context).fiats[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (selectedFiat.name ==
                                          Provider.of<FiatList>(context,
                                                  listen: false)
                                              .fiats[index]
                                              .name &&
                                      selectedFiat.diminutive ==
                                          Provider.of<FiatList>(context,
                                                  listen: false)
                                              .fiats[index]
                                              .diminutive)
                                  ? Colors.amberAccent[400]
                                  : Colors.grey[300],
                            ),
                          ),
                          subtitle: Text(
                            Provider.of<FiatList>(context)
                                .fiats[index]
                                .diminutive,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (selectedFiat.name ==
                                          Provider.of<FiatList>(context,
                                                  listen: false)
                                              .fiats[index]
                                              .name &&
                                      selectedFiat.diminutive ==
                                          Provider.of<FiatList>(context,
                                                  listen: false)
                                              .fiats[index]
                                              .diminutive)
                                  ? Colors.amberAccent[400]
                                  : Colors.grey[400],
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                Provider.of<FiatList>(context)
                                    .fiats[index]
                                    .logoUrl),
                            backgroundColor: Colors.transparent,
                          ),
                          trailing: (selectedFiat.name ==
                                      Provider.of<FiatList>(context)
                                          .fiats[index]
                                          .name &&
                                  selectedFiat.diminutive ==
                                      Provider.of<FiatList>(context)
                                          .fiats[index]
                                          .diminutive)
                              ? Icon(
                                  Icons.check,
                                  color: Colors.amberAccent[400],
                                )
                              : SizedBox(),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey[200],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    selectedFiat = (selectedFiat == null)
        ? Provider.of<FiatList>(context).fiats[0]
        : selectedFiat;

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
                                _buildCryptoModal(context);
                              },
                              textColor: Colors.grey[900],
                              color: Colors.amberAccent[400],
                              child: Container(
                                child: Consumer<CryptoList>(
                                  builder: (context, value, child) {
                                    if (selectedCrypto == null) {
                                      if (value.cryptos.length > 0) {
                                        selectedCrypto = value.cryptos[0];
                                      }
                                    }
                                    return Text(
                                      (selectedCrypto == null)
                                          ? ""
                                          : selectedCrypto.diminutive
                                              .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _leftTextController,
                            onChanged: (value) async {
                              // await getData(true);
                              _rightTextController.value = TextEditingValue(
                                  text: await ChangeCurrency.change(
                                      false,
                                      selectedCrypto,
                                      selectedFiat,
                                      _leftTextController.value.text),
                                  selection: TextSelection.fromPosition(
                                      TextPosition(offset: value.length)));
                            },
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
                          Icons.swap_horiz,
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
                                _buildFiatModal(context);
                              },
                              textColor: Colors.grey[900],
                              color: Colors.amberAccent[400],
                              child: Container(
                                child: Text(
                                  selectedFiat.diminutive.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _rightTextController,
                            onChanged: (value) async {
                              _leftTextController.value = TextEditingValue(
                                  text: await ChangeCurrency.change(
                                      true,
                                      selectedCrypto,
                                      selectedFiat,
                                      _rightTextController.value.text),
                                  selection: TextSelection.fromPosition(
                                      TextPosition(offset: value.length)));
                            },
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
