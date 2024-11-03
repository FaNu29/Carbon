import 'package:flutter/material.dart';
import 'package:carbon/bar/bar_graph.dart';
import 'package:carbon/HomeScreen/HomePg.dart';
import 'package:carbon/HomeScreen/HomeDrawer.dart';
import 'package:carbon/BottomNavBar/BottomNavBar.dart';
import 'package:carbon/ProfilePage.dart';
import 'package:carbon/bar/pieChart.dart';

class CarbonTracker extends StatefulWidget {
  const CarbonTracker({Key? key}) : super(key: key);

  @override
  State<CarbonTracker> createState() => _CarbonTrackerState();
}

class _CarbonTrackerState extends State<CarbonTracker> {
  List<double> weekly_emission = [
    28.5,
    29.3,
    30.5,
    50.3,
    21.5,
    45.3,
    23.48,
  ];

  List<double> monthly_emission = [
    78.5,
    15.3,
    7.5,
    40.3,
    95.5,
    85.3,
    58.48,
  ];

  List<double> yearly_emission = [
    78.5,
    15.3,
    70.5,
    4.3,
    95.5,
    82.3,
    67.48,
  ];

  List<double> currentEmissionData = []; // Initially show weekly data
  int selectedIndex = 0; // Track the selected button

  @override
  void initState() {
    super.initState();
    currentEmissionData = weekly_emission; // Start with weekly emission data
  }

  void switchEmissionData(int index) {
    setState(() {
      selectedIndex = index;
      if (index == 0) {
        currentEmissionData = weekly_emission;
      } else if (index == 1) {
        currentEmissionData = monthly_emission;
      } else if (index == 2) {
        currentEmissionData = yearly_emission;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Carbon Footprint Tracker",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, // Disable default leading icon (back button)
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu), // Drawer icon
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open drawer on icon press
              },
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 40, // Set a fixed width for the container
              height: 40, // Set a fixed height for the container
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.lightGreen,
              ),
              child: IconButton(
                icon: Icon(Icons.person),
                color: Colors.lightGreen[800],
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate 1/3 of the available height
          double halfHeight = constraints.maxHeight / 2;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Row of buttons to switch between emission data
              SizedBox(
                height: 40, // Height of the button row
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedIndex == 0 ? Colors.green[50] : Colors.grey[300],
                          foregroundColor: selectedIndex == 0 ? Colors.green[900] : Colors.black,
                        ),
                        onPressed: () => switchEmissionData(0), // Weekly button
                        child: Text("Weekly Emission"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedIndex == 1 ? Colors.green[50] : Colors.grey[300],
                          foregroundColor: selectedIndex == 1 ? Colors.green[900] : Colors.black,
                        ),
                        onPressed: () => switchEmissionData(1), // Monthly button
                        child: Text("Monthly Emission"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedIndex == 2 ? Colors.green[50] : Colors.grey[300],
                          foregroundColor: selectedIndex == 2 ? Colors.green[900] : Colors.black,
                        ),
                        onPressed: () => switchEmissionData(2), // Yearly button
                        child: Text("Yearly Emission"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 6), // Small gap between buttons and chart

              // Container for the bar chart
              Container(
                height: halfHeight, // Occupy 1/3 of available height
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CoBarGraph(
                    weeklySummary: currentEmissionData,
                  ),
                ),
              ),
              SizedBox(height: 5), // Small gap between chart and text container

              // Text container for "Category Chart"
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Category Chart",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Container for the pie chart and legend
              CategoryPieChart(
                data: {
                  'food': 20,
                  'electricity': 30,
                  'transportation': 25,
                  'waste': 15,
                  'consumption': 10,
                },
              ),
            ],
          );
        },
      ),
      drawer: const HomeDrawer(),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}
