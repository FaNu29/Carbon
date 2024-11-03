import 'package:flutter/material.dart';
import 'package:carbon/HomeScreen/HomeDrawer.dart';
import 'package:carbon/BottomNavBar/BottomNavBar.dart';

class Recycle1stpg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Recycle'),
        backgroundColor: Color(0xFFD6EBE0),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: const HomeDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: screenSize.height / 3,
            width: screenSize.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/recycle1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListItem(
                  label: 'Plastic',
                  image: 'assets/plastic.jpg',
                  recycledValue: '20 kg',
                  points: '100 points',
                ),
                ListItem(
                  label: 'Organic',
                  image: 'assets/organic.jpg',
                  recycledValue: '15 kg',
                  points: '75 points',
                ),
                ListItem(
                  label: 'Glass',
                  image: 'assets/glass.jpg',
                  recycledValue: '10 kg',
                  points: '50 points',
                ),
                ListItem(
                  label: 'Metal',
                  image: 'assets/metal.jpg',
                  recycledValue: '8 kg',
                  points: '40 points',
                ),
                ListItem(
                  label: 'Paper',
                  image: 'assets/paper.jpg',
                  recycledValue: '12 kg',
                  points: '60 points',
                ),
                ListItem(
                  label: 'E-waste',
                  image: 'assets/e-waste.jpg',
                  recycledValue: '5 kg',
                  points: '25 points',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}

class ListItem extends StatefulWidget {
  final String label;
  final String image;
  String recycledValue;
  final String points;

  ListItem({
    required this.label,
    required this.image,
    required this.recycledValue,
    required this.points,
  });

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool showTextField = false;
  final TextEditingController _controller = TextEditingController();

  void _recycleMore() {
    setState(() {
      showTextField = !showTextField;
    });
  }

  void _addWeight() {
    final double additionalWeight = double.tryParse(_controller.text) ?? 0.0;
    final double currentWeight = double.parse(widget.recycledValue.split(' ')[0]);
    final double newWeight = currentWeight + additionalWeight;

    setState(() {
      widget.recycledValue = '$newWeight kg';
      showTextField = false;
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Card(
      elevation: 3,
      margin: EdgeInsets.all(screenSize.width * 0.02),
      child: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.02),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: screenSize.width * 0.3,
                  width: screenSize.width * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        style: TextStyle(
                          fontSize: screenSize.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenSize.width * 0.02),
                      Text(
                        'Recycled: ${widget.recycledValue}',
                        style: TextStyle(fontSize: screenSize.width * 0.04),
                      ),
                      Text(
                        'Points: ${widget.points}',
                        style: TextStyle(fontSize: screenSize.width * 0.04),
                      ),
                      SizedBox(height: screenSize.width * 0.02),
                      ElevatedButton(
                        onPressed: _recycleMore,
                        child: Text(
                          'Recycle More',
                          style: TextStyle(fontSize: screenSize.width * 0.04),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (showTextField)
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.width * 0.02,
                  left: screenSize.width * 0.34, // Align with the text vertically
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Add Weight (kg)',
                        ),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.02),
                    ElevatedButton(
                      onPressed: _addWeight,
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: screenSize.width * 0.04),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
