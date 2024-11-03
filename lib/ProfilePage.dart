import 'package:carbon/BottomNavBar/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String username = 'Shahrin Ahmed';
  int leaderboardPosition = 1;
  int recyclePoints = 100;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.15, // Responsive radius
                    backgroundImage: _image != null ? FileImage(_image!) : AssetImage('assets/person_icon.png') as ImageProvider<Object>,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      alignment: Alignment.bottomRight,
                      child: Icon(Icons.camera_alt, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              username,
              style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold), // Responsive font size
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Leaderboard Position',
                        style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500), // Responsive font size
                      ),
                      Text(
                        '$leaderboardPosition',
                        style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500), // Responsive font size
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Recycle Points',
                        style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500), // Responsive font size
                      ),
                      Text(
                        '$recyclePoints',
                        style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500), // Responsive font size
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit Username'),
                    onTap: () {
                      // Implement edit username functionality
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit Name'),
                    onTap: () {
                      // Implement edit name functionality
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('Review Info'),
                    onTap: () {
                      // Implement review info functionality
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Share with Friends'),
                    onTap: () {
                      // Implement share with friends functionality
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}
