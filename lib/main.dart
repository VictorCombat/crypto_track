import 'package:crypto_track/pages/favorites.dart';
import 'package:flutter/material.dart';
import 'package:crypto_track/pages/home.dart';

void main() => runApp(MaterialApp(
      // initialRoute: '/home',
      routes: {
        '/root': (context) => RootWidget(),
        '/home': (context) => Home(),
        '/favorites': (context) {
          _RootWidgetState._currentIndex = 0;
          return RootWidget();
        }
      },
      debugShowCheckedModeBanner: false,
      home: RootWidget(),
    ));

class Destination {
  final String title;
  final IconData icon;
  final IconData iconUnselected;
  final Widget widget;

  const Destination({this.title, this.icon, this.iconUnselected, this.widget});
}

class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  static int _currentIndex = 1;
  List<Widget> pages = [Home(), Favorites()];
  List<Destination> allDestinations = <Destination>[
    Destination(
        title: 'Favorites',
        icon: Icons.star,
        iconUnselected: Icons.star_border,
        widget: Favorites()),
    Destination(
        title: 'Home',
        icon: Icons.home,
        iconUnselected: Icons.hotel,
        widget: Home()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: allDestinations.map((Destination destination) {
            return destination.widget;
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.amberAccent[400],
        backgroundColor: Colors.grey[800],
        items: allDestinations.map((Destination destination) {
          return BottomNavigationBarItem(
            icon: Icon(
              (_currentIndex == allDestinations.indexOf(destination))
                  ? destination.icon
                  : destination.iconUnselected,
              // color: Colors.amberAccent[400],
            ),
            title: Text(
              destination.title,
              // style: TextStyle(
              //   color: Colors.amberAccent[400],
              // ),
            ),
            backgroundColor: Colors.grey[900],
          );
        }).toList(),
      ),
    );
  }
}
