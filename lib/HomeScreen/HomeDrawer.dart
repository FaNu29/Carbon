import 'package:carbon/Event/eventPage.dart';
import 'package:carbon/media/social_home_page.dart';
import 'package:flutter/material.dart';
import 'package:carbon/Recycle/Recycle1stpg.dart';
import 'package:carbon/ProfilePage.dart';
import 'package:carbon/TipsPage.dart';
import 'package:carbon/Style/UiHelper.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: UiHelper.gradientDecoration(context).gradient,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  child: CircleAvatar(
                    radius: screenWidth * 0.08, // Responsive radius based on screen width
                    backgroundImage: AssetImage('assets/space.jpg'), // Placeholder image
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Responsive spacing
                Text(
                  'Username', // Replace with actual username from ProfilePage
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: screenWidth * 0.06, // Responsive font size based on screen width
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Recycle'),
            leading: Icon(Icons.recycling),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Recycle1stpg()),
              );
            },
          ),


          ListTile(
            title: Text('Leaderboard'),
            leading: Icon(Icons.bar_chart),
            onTap: () {
              Navigator.pop(context); // Closes the drawer
            },
          ),
          ListTile(
            title: Text('Events'),
            leading: Icon(Icons.event),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Eventpage()),
              ); // Closes the drawer
            },
          ),
          ListTile(
            title: Text('Tips'),
            leading: Icon(Icons.lightbulb_outline),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TipsPage()),
              );
            },
          ),
          ListTile(
            title: Text('Description'),
            leading: Icon(Icons.description),
            onTap: () {
              Navigator.pop(context); // Closes the drawer
            },
          ),
        ],
      ),
    );
  }
}
