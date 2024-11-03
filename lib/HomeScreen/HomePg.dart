import 'package:carbon/HomeScreen/HomeBody.dart';
import 'package:carbon/carbonTracker.dart';
import 'package:carbon/ProfilePage.dart';
import 'package:carbon/BottomNavBar/BottomNavBar.dart';
import 'package:flutter/material.dart';

import 'HomeDrawer.dart';

class Homepg extends StatefulWidget {
  const Homepg({super.key});

  @override
  State<Homepg> createState() => _HomepgState();
}

class _HomepgState extends State<Homepg> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer:  HomeDrawer(),
      body:  HomeBody(),
      bottomNavigationBar:
      const BottomNavBar(currentIndex: 0),
    );
  }
}
