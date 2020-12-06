import 'package:crypto_track/model/crypto.dart';
import 'package:crypto_track/model/crypto_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cryptos extends StatefulWidget {
  @override
  _CryptosState createState() => _CryptosState();
}

class _CryptosState extends State<Cryptos> {
  Color changeColor;
  TextEditingController _textController = TextEditingController();

  CryptoList initialList;
  List<Crypto> queryList = List<Crypto>();
  bool isSearching = false;

  bool _containsIgnoreCase(String s1, String s2) {
    return s1.toLowerCase().contains(s2.toLowerCase());
  }

  void _filterSearchResults(String query) {
    List<Crypto> tmpList = List<Crypto>();
    if (query.isNotEmpty) {
      isSearching = true;
      initialList.cryptos.forEach((element) {
        if (_containsIgnoreCase(element.name, query)) {
          tmpList.add(element);
        }
      });

      setState(() {
        queryList.clear();
        queryList.addAll(tmpList);
      });
    } else {
      isSearching = false;
      setState(() {
        queryList.clear();
        queryList.addAll(initialList.cryptos);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
      ),
      body: Column(
        children: [
          /* ============ SEARCH BAR ============ */
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              //TODO: FIND A WAY TO OVERRIDE COLOR PROPERTY OF textSelectionHandle
              controller: _textController,
              onChanged: _filterSearchResults,
              cursorColor: Colors.amberAccent[400],
              style: TextStyle(color: Colors.grey[300]),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.amberAccent[400],
                ),
                hintText: 'Search for cryptos (Bitcoin, Ethereum, etc.)',
                hintStyle: TextStyle(
                  color: Colors.amberAccent[400],
                  fontStyle: FontStyle.italic,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.amberAccent[400],
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.amberAccent[400],
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.amberAccent[400],
                  ),
                ),
              ),
            ),
          ),
          /* ============ CRYPTOS LIST ============ */
          Expanded(
            child: Consumer<CryptoList>(
              builder: (context, value, child) {
                initialList = value;
                if (queryList.length == 0 && !isSearching)
                  queryList.addAll(initialList.cryptos);

                return ListView.separated(
                  itemCount: queryList.length,
                  itemBuilder: (context, index) {
                    Crypto currentCrypto = queryList.elementAt(index);
                    changeColor = (currentCrypto.changeValue == null)
                        ? Colors.grey[400]
                        : (double.parse(currentCrypto.changeValue) >= 0)
                            ? Colors.greenAccent[700]
                            : Colors.redAccent[700];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 4.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/crypto_details',
                              arguments: currentCrypto);
                        },
                        title: Text(
                          currentCrypto.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[300],
                          ),
                        ),
                        subtitle: Text(
                          currentCrypto.diminutive,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400],
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(currentCrypto.logoUrl),
                          backgroundColor: Colors.transparent,
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              double.parse(currentCrypto.price)
                                      .toStringAsFixed(2) +
                                  '€/\$',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[300],
                              ),
                            ),
                            Text(
                              currentCrypto.change +
                                  ' ' +
                                  ((currentCrypto.changeValue == null)
                                      ? 'N/A'.toString()
                                      : double.parse(currentCrypto.changeValue)
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
  }
}
