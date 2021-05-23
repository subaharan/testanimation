import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_animation/utils/images.dart';

import 'home.dart';

class BottomHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomHomeState();
  }
}

class _BottomHomeState extends State<BottomHome> {


  int _selectedIndex=2;
  final _widgetOptions = [
    HomeWidget(),
    HomeWidget(),
    HomeWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            activeIcon:  SvgPicture.asset(
              Images.bulb,
            ),
            icon: Icon(Icons.lightbulb_outline, color: Colors.grey,),
label: ""
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              Images.home,
            ),
            icon: Icon(Icons.home_outlined, color: Colors.grey,),
              label: ""
          ),
          BottomNavigationBarItem(
            activeIcon:  SvgPicture.asset(
              Images.settings,
            ),
              icon: Icon(Icons.settings, color: Colors.grey,),
              label: ""
          )
        ],
      ),
    );
  }
}