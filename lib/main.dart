import 'package:crypto_track/model/crypto_list.dart';
import 'package:crypto_track/model/fiat_list.dart';
import 'package:crypto_track/pages/crypto_details.dart';
import 'package:crypto_track/pages/cryptos.dart';
import 'package:crypto_track/pages/favorites.dart';
import 'package:flutter/material.dart';
import 'package:crypto_track/pages/home.dart';
import 'package:flutter/physics.dart';
import 'package:provider/provider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => CryptoList(),
          ),
          ChangeNotifierProvider(
            create: (context) => FiatList(),
          ),
        ],
        child: MaterialApp(
          initialRoute: '/root',
          routes: {
            '/root': (context) => RootWidget(),
            '/home': (context) => Home(),
            '/favorites': (context) {
              _RootWidgetState._currentIndex = 0;
              return RootWidget();
            },
            '/crypto_details': (context) => CryptoDetails(),
          },
          // home: RootWidget(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );

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
  List<Destination> allDestinations = <Destination>[
    Destination(
      title: 'Favorites',
      icon: Icons.star,
      iconUnselected: Icons.star_border,
      widget: Favorites(),
    ),
    Destination(
      title: 'Home',
      icon: Icons.home,
      iconUnselected: Icons.hotel,
      widget: Home(),
    ),
    Destination(
      title: 'Search',
      icon: Icons.search,
      iconUnselected: Icons.search,
      widget: Cryptos(),
    ),
  ];

  Future<void> _onRefresh() async {
    await Provider.of<CryptoList>(context, listen: false).getData();
    print('[REFRESH COMPLETE]');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: allDestinations.map((Destination destination) {
            return RefreshIndicator(
                onRefresh: _onRefresh, child: destination.widget);
          }).toList(),
        ),
      ),
      bottomNavigationBar: _buildNavBar(context),
    );
  }

  /* TEST BOTTOM NAV BAR */

  _buildNavBar(context) {
    return ConvexAppBar(
      initialActiveIndex: _currentIndex,
      style: TabStyle.react,
      items: allDestinations.map((Destination destination) {
        return TabItem(
          icon: Icon(
            destination.icon,
            // (_currentIndex == allDestinations.indexOf(destination))
            //     ? destination.icon
            //     : destination.iconUnselected,
            color: (_currentIndex == allDestinations.indexOf(destination))
                ? Colors.amberAccent[400]
                : Colors.grey[300],
          ),
          title: destination.title,
        );
      }).toList(),
      backgroundColor: Colors.grey[800],
      activeColor: Colors.amberAccent[400],
      color: Colors.grey[300],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  _buildOldNavBar(context) {
    return BottomNavigationBar(
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
            destination.icon,
            // (_currentIndex == allDestinations.indexOf(destination))
            //     ? destination.icon
            //     : destination.iconUnselected,
            color: (_currentIndex == allDestinations.indexOf(destination))
                ? Colors.amberAccent[400]
                : Colors.grey[300],
          ),
          title: Text(
            destination.title,
            style: TextStyle(
              color: (_currentIndex == allDestinations.indexOf(destination))
                  ? Colors.amberAccent[400]
                  : Colors.grey[300],
            ),
          ),
          backgroundColor: Colors.grey[900],
        );
      }).toList(),
    );
  }

  _getNavBar(context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: ClipPath(
            clipper: NavBarClipper(),
            child: Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.teal,
                      Colors.teal.shade900,
                    ]),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 45.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(Icons.bubble_chart, false),
              SizedBox(
                width: 1,
              ),
              _buildNavItem(Icons.landscape, true),
              SizedBox(
                width: 1,
              ),
              _buildNavItem(Icons.brightness_3, false),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Focus',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 1,
              ),
              Text(
                'Relax',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 1,
              ),
              Text(
                'Sleep',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildNavItem(IconData icon, bool active) {
    return CircleAvatar(
      radius: 38,
      backgroundColor: Colors.teal.shade900,
      child: CircleAvatar(
        radius: 25,
        backgroundColor:
            active ? Colors.white.withOpacity(0.9) : Colors.transparent,
        child: Icon(
          icon,
          color: active ? Colors.black : Colors.white.withOpacity(0.9),
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('[APP CLOSING] Cancelling timer.');
    Provider.of<CryptoList>(context, listen: false).timer?.cancel();
    print('[APP CLOSING] Cancelled timer.');
    super.dispose();
  }
}

class NavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;

    // path.cubicTo(sw / 12, 0, sw / 12, 2 * sh / 5, 2 * sw / 12, 2 * sh / 5);
    // path.cubicTo(3 * sw / 12, 2 * sh / 5, 3 * sw / 12, 0, 4 * sw / 12, 0);
    // path.cubicTo(
    //     5 * sw / 12, 0, 5 * sw / 12, 2 * sh / 5, 6 * sw / 12, 2 * sh / 5);
    // path.cubicTo(7 * sw / 12, 2 * sh / 5, 7 * sw / 12, 0, 8 * sw / 12, 0);
    // path.cubicTo(
    //     9 * sw / 12, 0, 9 * sw / 12, 2 * sh / 5, 10 * sw / 12, 2 * sh / 5);
    // path.cubicTo(11 * sw / 12, 2 * sh / 5, 11 * sw / 12, 0, sw, 0);

    path.lineTo(sw / 2.0, 0.0);
    path.lineTo(sw / 2.0, sh / 2.0);
    path.lineTo(0, sh / 2.0);
    path.lineTo(0, 0);

    // path.lineTo(sw, sh);
    // path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
