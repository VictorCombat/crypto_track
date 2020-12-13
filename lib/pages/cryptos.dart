import 'package:crypto_track/model/crypto.dart';
import 'package:crypto_track/model/crypto_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum SortBy { MARKET_CAP, PERFORMERS, VOLUME, ALPHABETICAL }
enum OrderBy { ASC, DESC }

class Cryptos extends StatefulWidget {
  @override
  _CryptosState createState() => _CryptosState();
}

class _CryptosState extends State<Cryptos> {
  SortBy _sortBy = SortBy.MARKET_CAP;
  OrderBy _orderBy = OrderBy.ASC;

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

  void _sort(SortBy sortBy, OrderBy orderBy) {
    print("SORTING: sortBy $sortBy, orderBy $orderBy");

    setState(() {
      queryList.sort((a, b) {
        if (orderBy == OrderBy.DESC) {
          Crypto tmp = b;
          b = a;
          a = tmp;
        }

        switch (sortBy) {
          case SortBy.ALPHABETICAL:
            return a.name.compareTo(b.name);
            break;
          case SortBy.MARKET_CAP:
            return double.parse(a.marketCap)
                .compareTo(double.parse(b.marketCap));
            break;
          case SortBy.PERFORMERS:
            // TODO: FIX THIS
            double aval = double.tryParse(a.change);
            double bval = double.tryParse(b.change);
            if (aval == null || bval == null)
              return -1;
            else
              return aval.compareTo(bval);
            break;
          case SortBy.VOLUME:
            return double.parse(a.totalVolume)
                .compareTo(double.parse(b.totalVolume));
            break;
        }

        return -1;
      });
    });
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
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: TextField(
                    //TODO: FIND A WAY TO OVERRIDE COLOR PROPERTY OF textSelectionHandle
                    controller: _textController,
                    onChanged: _filterSearchResults,
                    cursorColor: Colors.amberAccent[400],
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14.0,
                    ),
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
                SizedBox(
                  width: 10.0,
                ),
                /* ============ SORT BUTTON ============ */
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.sort,
                      color: Colors.amberAccent[400],
                      size: 25.0,
                    ),
                    onPressed: () {
                      _buildSortModal(context);
                    },
                  ),
                ),
              ],
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

  void _buildSortModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
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
                    Text(
                      "Sort by",
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: [
                        _buildRowSort("Market Cap", SortBy.MARKET_CAP),
                        _buildRowSort("Performers", SortBy.PERFORMERS),
                        _buildRowSort("Volume", SortBy.VOLUME),
                        _buildRowSort("Alphabetical", SortBy.ALPHABETICAL),
                      ],
                    ).toList(),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildRowSort(String title, SortBy sortBy) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: (_sortBy == sortBy) ? FontWeight.bold : FontWeight.normal,
          color: Colors.grey[900],
        ),
      ),
      trailing: Container(
        child: ToggleButtons(
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
          color: Colors.amberAccent[400],
          selectedColor: Colors.grey[900],
          fillColor: Colors.amberAccent[400],
          isSelected: (_sortBy != sortBy)
              ? [false, false]
              : (_orderBy == OrderBy.ASC) ? [true, false] : [false, true],
          children: [
            Text('ASC'),
            Text('DESC'),
          ],
          onPressed: (index) {
            _sortBy = sortBy;
            _orderBy = OrderBy.values[index];
            _sort(_sortBy, _orderBy);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
