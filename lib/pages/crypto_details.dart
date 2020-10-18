import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crypto_track/model/crypto.dart';
import 'package:crypto_track/model/crypto_list.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CryptoDetails extends StatefulWidget {
  @override
  _CryptoDetailsState createState() => _CryptoDetailsState();
}

class _CryptoDetailsState extends State<CryptoDetails> {
  Crypto crypto;
  List<bool> isSelected = [false, true, false, false, false];
  HistoricalDataType type = HistoricalDataType.one_day;

  List<Data> data = [];
  String currPrice;
  String currencySetting = "€"; //TODO: set in Settings page
  Widget chart;

  Future<List<charts.Series<Data, DateTime>>> _getSeriesData() async {
    await crypto.getHistoricalData(type);
    print('[SIZE OF DATA]: ${crypto.historicalData.data.length}');

    data = crypto.historicalData.data;

    List<charts.Series<Data, DateTime>> series = [
      charts.Series(
          id: "HistoricalData",
          data: data,
          domainFn: (Data series, _) => series.date,
          measureFn: (Data series, _) => double.parse(series.price),
          colorFn: (Data series, _) => charts.MaterialPalette.blue.shadeDefault)
    ];

    return Future.value(series);
  }

  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    if (selectedDatum.isNotEmpty) {
      setState(() {
        currPrice =
            double.parse(selectedDatum.first.datum.price).toStringAsFixed(2);
      });
    }
  }

  Widget _buildChart() {
    return FutureBuilder(
      future: _getSeriesData(),
      builder: (context, snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Expanded(
              child: charts.TimeSeriesChart(
                snapshot.data,
                animate: true,
                behaviors: [
                  charts.LinePointHighlighter(
                      showHorizontalFollowLine:
                          charts.LinePointHighlighterFollowLineType.all,
                      showVerticalFollowLine:
                          charts.LinePointHighlighterFollowLineType.all),
                  charts.SelectNearest(
                      eventTrigger: charts.SelectionTrigger.pressHold)
                ],
                selectionModels: [
                  charts.SelectionModelConfig(
                    type: charts.SelectionModelType.info,
                    changedListener: _onSelectionChanged,
                  ),
                ],
                primaryMeasureAxis: charts.NumericAxisSpec(
                  tickProviderSpec:
                      charts.BasicNumericTickProviderSpec(zeroBound: false),
                ),
              ),
            ),
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            )
          ];
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    crypto =
        crypto != null ? crypto : ModalRoute.of(context).settings.arguments;

    currPrice = currPrice == null ? crypto.price : currPrice;
    chart = _buildChart();
  }

  @override
  Widget build(BuildContext context) {
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
          // IconButton(
          //   icon: Icon(Icons.notifications),
          //   onPressed: () {
          //     print('TAP');
          //   },
          // ),
        ],
      ),
      body: Scrollbar(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$currPrice $currencySetting',
                  style: TextStyle(
                    color: Colors.grey[300],
                  ),
                ),
                Text(
                  crypto.change +
                      ' ' +
                      ((crypto.changeValue == null)
                          ? 'N/A'.toString()
                          : double.parse(crypto.changeValue)
                              .abs()
                              .toStringAsFixed(2)) +
                      '%',
                  style: TextStyle(
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 250.0,
              width: MediaQuery.of(context).size.width,
              child: chart == null ? _buildChart() : chart,
            ),
            ToggleButtons(
              isSelected: isSelected,
              children: [
                Text('8H'),
                Text('1D'),
                Text('1W'),
                Text('1M'),
                Text('6M'),
              ],
              onPressed: (index) {
                setState(() {
                  chart = null;

                  for (int buttonIndex = 0;
                      buttonIndex < isSelected.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      isSelected[buttonIndex] = true;
                    } else {
                      isSelected[buttonIndex] = false;
                    }
                  }

                  type = HistoricalDataType.values[index];
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
