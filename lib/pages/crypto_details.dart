import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crypto_track/model/crypto.dart';
import 'package:crypto_track/model/crypto_list.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CryptoDetails extends StatefulWidget {
  @override
  _CryptoDetailsState createState() => _CryptoDetailsState();
}

class _CryptoDetailsState extends State<CryptoDetails> {
  Crypto crypto;
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  List<bool> isSelected = [false, true, false, false, false];
  HistoricalDataType type = HistoricalDataType.one_day;
  List<String> titles = ['T'];

  List<Data> data = [
    // new SalesData(0, 1500000),
    // new SalesData(1, 1735000),
    // new SalesData(2, 1678000),
    // new SalesData(3, 1890000),
    // new SalesData(4, 1907000),
    // new SalesData(5, 2300000),
    // new SalesData(6, 2360000),
    // new SalesData(7, 1980000),
    // new SalesData(8, 2654000),
    // new SalesData(9, 2789070),
    // new SalesData(10, 3020000),
    // new SalesData(11, 3245900),
    // new SalesData(12, 4098500),
    // new SalesData(13, 4500000),
    // new SalesData(14, 4456500),
    // new SalesData(15, 3900500),
    // new SalesData(16, 5123400),
    // new SalesData(17, 5589000),
    // new SalesData(18, 5940000),
  ];
  // _getSeriesData() {
  //   return _getData();
  // }

  _getData() async {
    await crypto.getHistoricalData(type);

    data = crypto.historicalData.data;

    List<charts.Series<Data, DateTime>> series = [
      charts.Series(
          id: "HistoricalData",
          data: data,
          domainFn: (Data series, _) => series.date,
          measureFn: (Data series, _) => double.parse(series.price),
          colorFn: (Data series, _) => charts.MaterialPalette.blue.shadeDefault)
    ];

    return series;
  }

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
      // print(selectedDatum.first.datum.price);
    }
  }

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
      body: Scrollbar(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$/€ XX,XXX',
                  style: TextStyle(
                    color: Colors.grey[300],
                  ),
                ),
                Text(
                  '+XX%',
                  style: TextStyle(
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 250.0,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
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
                                showHorizontalFollowLine: charts
                                    .LinePointHighlighterFollowLineType.all,
                                showVerticalFollowLine: charts
                                    .LinePointHighlighterFollowLineType.all),
                            charts.SelectNearest(
                                eventTrigger:
                                    charts.SelectionTrigger.tapAndDrag)
                          ],
                          selectionModels: [
                            charts.SelectionModelConfig(
                              type: charts.SelectionModelType.info,
                              changedListener: _onSelectionChanged,
                            ),
                          ],
                          primaryMeasureAxis: charts.NumericAxisSpec(
                            tickProviderSpec:
                                charts.BasicNumericTickProviderSpec(
                                    zeroBound: false),
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
              ),
              // charts.TimeSeriesChart(
              //   _getSeriesData(),
              //   animate: true,
              //   behaviors: [
              //     charts.LinePointHighlighter(
              //         showHorizontalFollowLine:
              //             charts.LinePointHighlighterFollowLineType.all,
              //         showVerticalFollowLine:
              //             charts.LinePointHighlighterFollowLineType.all),
              //     charts.SelectNearest(
              //         eventTrigger: charts.SelectionTrigger.tapAndDrag)
              //   ],
              //   selectionModels: [
              //     charts.SelectionModelConfig(
              //       type: charts.SelectionModelType.info,
              //       changedListener: _onSelectionChanged,
              //     ),
              //   ],
              // ),
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
                  //_calcTitles(index);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _calcTitles(int index) {
    titles.clear();
    switch (index) {
      case 0:
        _8h();
        break;
      case 1:
        _1d();
        break;
      case 2:
        _1w();
        break;
    }
  }

  void _8h() {
    var now = DateTime.now();
    var tmp = now;
    for (int i = 6; i >= 0; i--) {
      tmp = now.subtract(new Duration(hours: 1) * i);
      String formattedDate = DateFormat('kk:mm').format(tmp);
      titles.add(formattedDate);
    }
  }

  void _1d() {
    var now = DateTime.now();
    var tmp = now;
    for (int i = 6; i >= 0; i--) {
      tmp = now.subtract(new Duration(hours: 3, minutes: 30) * i);
      String formattedDate = DateFormat('kk:mm').format(tmp);
      titles.add(formattedDate);
    }
  }

  void _1w() {
    var now = DateTime.now();
    var tmp = now;
    for (int i = 6; i >= 0; i--) {
      tmp = now.subtract(new Duration(days: 1) * i);
      String formattedDate = DateFormat('d LLL').format(tmp);
      titles.add(formattedDate);
    }
  }
}

// class SalesData {
//   final int year;
//   final int sales;

//   SalesData(this.year, this.sales);
// }

// class CryptoData {
//   final DateTime date;
//   final double price;

//   CryptoData(this.date, this.price);
// }

// LineChart(
//   LineChartData(
//     gridData: FlGridData(
//       show: true,
//       drawVerticalLine: true,
//     ),
//     titlesData: FlTitlesData(
//       show: true,
//       bottomTitles: SideTitles(
//         showTitles: true,
//         reservedSize: 22,
//         textStyle: const TextStyle(
//             color: Color(0xff68737d),
//             fontWeight: FontWeight.bold,
//             fontSize: 9),
//         getTitles: (value) {
//           return titles[value.toInt()];
//         },
//         margin: 8,
//       ),
//       leftTitles: SideTitles(
//         showTitles: true,
//         textStyle: const TextStyle(
//           color: Color(0xff67727d),
//           fontWeight: FontWeight.bold,
//           fontSize: 15,
//         ),
//         getTitles: (value) {
//           switch (value.toInt()) {
//             case 1:
//               return '10k';
//             case 3:
//               return '30k';
//             case 5:
//               return '50k';
//           }
//           return '';
//         },
//         reservedSize: 28,
//         margin: 12,
//       ),
//     ),
//     borderData: FlBorderData(
//         show: true,
//         border:
//             Border.all(color: const Color(0xff37434d), width: 1)),
//     minX: 0,
//     maxX: 6,
//     minY: 0,
//     maxY: 6,
//     lineBarsData: [
//       LineChartBarData(
//         spots: [
//           FlSpot(0, 3),
//           FlSpot(1.1, 2),
//           FlSpot(1.5, 5),
//           FlSpot(2.3, 3.1),
//           FlSpot(3.5, 4),
//           FlSpot(5.2, 4),
//           FlSpot(6, 3),
//         ],
//         isCurved: false,
//         colors: gradientColors,
//         barWidth: 3,
//         isStrokeCapRound: false,
//         dotData: FlDotData(
//           show: true,
//         ),
//         belowBarData: BarAreaData(
//           show: true,
//           colors: gradientColors
//               .map((color) => color.withOpacity(0.3))
//               .toList(),
//         ),
//       ),
//     ],
//   ),
// ),
