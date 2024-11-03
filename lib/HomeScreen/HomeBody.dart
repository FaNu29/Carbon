import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carbon/Daily Checker/dailyCheck.dart';
import 'package:carbon/bar/ArchProgress.dart';
import 'package:carbon/ProfilePage.dart'; // Import your profile page

class HomeBody extends StatelessWidget {

   HomeBody({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Background image
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            child: Image.asset(
              'assets/Home.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Neumorphic-styled container for ArcProgressBar
          Positioned(
            top: MediaQuery.of(context).size.height / 3 + 70,
            left: MediaQuery.of(context).size.width * 0.04,
            right: MediaQuery.of(context).size.width * 0.04,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFA9C1F6), Color(0xFF709144)],
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                    child: ArcProgressBar(
                      value: 183,
                      maxValue: 300,
                      progressColor: Colors.blue,
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      text1: 'CO2 Emission',
                      text2: 'tons',
                      text: 'So far this month',
                      textStyleLabel: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Daily Checker",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DailyChecklist()),
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 9,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFA9C1F6), Color(0xFF709144)],
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.12,
                                height: MediaQuery.of(context).size.width * 0.12,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.width * 0.06,
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your daily checklist",
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.045,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                  ),
                                  Text(
                                    "A dynamic daily checklist for tracking and",
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.035,
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                  ),
                                  Text(
                                    "managing carbon footprint activities.",
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.035,
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: MediaQuery.of(context).size.height * 0.06,
              automaticallyImplyLeading: true,
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightGreen,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        CupertinoIcons.person_fill,
                        color: Colors.lightGreen[800],
                        size: MediaQuery.of(context).size.width * 0.06,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Main content
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.09,
              left: MediaQuery.of(context).size.width * 0.04,
              right: MediaQuery.of(context).size.width * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome!",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                Text(
                  "User Name",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                Text(
                  "Your emission is going well!☺",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
