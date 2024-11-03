import 'package:carbon/Recycle/Recycle1stpg.dart';
import 'package:carbon/media/social_home_page.dart';
import 'package:flutter/material.dart';
import 'package:carbon/HomeScreen/HomePg.dart';
import 'package:carbon/carbonTracker.dart';


class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Homepg()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CarbonTracker()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context)=> SocialHomePage()));
        break;

    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: true,
      backgroundColor: Colors.grey[300],
      elevation: 0,
      currentIndex: currentIndex,
      selectedItemColor: Colors.green[900],
      unselectedItemColor: Colors.green[900],
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.green[900]),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.eco, color: Colors.green[900]),
          label: "Carbon footprint tracker",
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.chat, color: Colors.green[900]),
          label: "EcoMedia",
        ),
      ],
      onTap: (index) => _onItemTapped(context, index),
    );
  }
}
