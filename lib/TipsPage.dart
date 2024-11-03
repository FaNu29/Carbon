import 'package:flutter/material.dart';
import 'package:carbon/Style/UiHelper.dart'; // Import your UiHelper for gradient decoration

class TipsPage extends StatelessWidget {
  final List<String> tips = [
    "Use energy-efficient appliances to reduce electricity consumption.",
    "Opt for public transportation or carpooling to reduce carbon emissions from commuting.",
    "Reduce, reuse, and recycle to minimize waste production.",
    "Conserve water by fixing leaks and using water-saving fixtures.",
    "Choose locally sourced and organic foods to reduce carbon emissions from food transportation and production.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tips to Reduce Carbon Footprint',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.045,
          ),
        ),
        backgroundColor: Color(0xFFACC4DA), // Set to your primary gradient color
        elevation: 0, // Remove appbar shadow
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.tertiary,
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
          itemCount: tips.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04, vertical: MediaQuery.of(context).size.height * 0.01),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300]?.withOpacity(0.5) ?? Colors.grey.withOpacity(0.5), // Ensure colors are not null
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Colors.amber,
                      size: MediaQuery.of(context).size.width * 0.08,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                    Expanded(
                      child: Text(
                        tips[index],
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
