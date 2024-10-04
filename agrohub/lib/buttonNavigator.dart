import 'package:agrohub/agriChat.dart';
import 'package:agrohub/challengePage.dart';
import 'package:agrohub/mapPage.dart';
import 'package:agrohub/const/ColorWillBe.dart';
import 'package:agrohub/homePage.dart';
import 'package:agrohub/homeSection.dart';
import 'package:agrohub/gamePage.dart';
import 'package:agrohub/notifications.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtomNavigationBar extends StatefulWidget {
  const ButtomNavigationBar({Key? key}) : super(key: key);

  @override
  State<ButtomNavigationBar> createState() => _ButtomNavigationBarState();
}

class _ButtomNavigationBarState extends State<ButtomNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeSection(),
    const ChallengePage(),
    const MapPage(),
    const Notifications(),
    AgriChat(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(Icons.home_filled, size: 25.h, color: colorWillBe.whiteColor),
          Icon(Icons.games_rounded, size: 25.h, color: colorWillBe.whiteColor),
          Icon(Icons.map_rounded, size: 25.h, color: colorWillBe.whiteColor),
          Icon(Icons.bar_chart_rounded,
              size: 25.h, color: colorWillBe.whiteColor),
          Icon(Icons.question_answer_rounded,
              size: 25.h, color: colorWillBe.whiteColor),
        ],
        color: colorWillBe.secondaryColor, // Set the color to white
        buttonBackgroundColor: colorWillBe.secondaryColor,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        height: 50.h,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
