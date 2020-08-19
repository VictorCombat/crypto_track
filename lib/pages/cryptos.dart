import 'package:crypto_track/model/crypto.dart';
import 'package:crypto_track/model/crypto_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class Cryptos extends StatefulWidget {
  @override
  _CryptosState createState() => _CryptosState();
}

class _CryptosState extends State<Cryptos> {
  Color changeColor;
  TextEditingController _textController = TextEditingController();

  onItemChanged(String value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: IconButton(
          icon: Icon(Icons.update),
          onPressed: () {
            Provider.of<CryptoList>(context, listen: false).getData();
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _textController,
              onChanged: onItemChanged,
              decoration: InputDecoration(
                hintText: 'Search coins',
              ),
            ),
          ),
          Expanded(
            child: Consumer<CryptoList>(
              builder: (context, value, child) {
                return ListView.separated(
                  itemCount: Provider.of<CryptoList>(context, listen: false)
                      .getLength(),
                  itemBuilder: (context, index) {
                    changeColor = (value.getAtIndex(index).changeValue == null)
                        ? Colors.grey[400]
                        : (value.getAtIndex(index).changeValue >= 0)
                            ? Colors.greenAccent[700]
                            : Colors.redAccent[700];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 4.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/crypto_details',
                              arguments: value.getAtIndex(index));
                        },
                        title: Text(
                          value.getAtIndex(index).name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[300],
                          ),
                        ),
                        subtitle: Text(
                          value.getAtIndex(index).diminutive,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400],
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(value.getAtIndex(index).logoUrl),
                          backgroundColor: Colors.transparent,
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              value.getAtIndex(index).price.toStringAsFixed(2) +
                                  '€/\$',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[300],
                              ),
                            ),
                            Text(
                              value.getAtIndex(index).change +
                                  ' ' +
                                  ((value.getAtIndex(index).changeValue == null)
                                      ? 'N/A'.toString()
                                      : value
                                          .getAtIndex(index)
                                          .changeValue
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
