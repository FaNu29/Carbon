import 'package:flutter/material.dart';

class DailyChecklist extends StatefulWidget {
  const DailyChecklist({Key? key}) : super(key: key);

  @override
  _DailyChecklistState createState() => _DailyChecklistState();
}

class _DailyChecklistState extends State<DailyChecklist> {
  final _formKey = GlobalKey<FormState>();
  bool usedPublicTransport = false;
  bool recycledWaste = false;
  double waterUsage = 0;
  String selectedTransportMedium = 'Car';
  double distance = 0;
  String distanceUnit = 'km';
  double mileage = 0;

  String selectedProcessedFood = '';
  String selectedMeat = '';
  String selectedDairy = '';
  String selectedGrain = '';

  final List<String> transportOptions = [
    'Car',
    'Bus',
    'Bike',
    'Rickshaw',
    'Public Transport',
    'Bicycle',
    'By Feet'
  ];

  final List<String> distanceUnits = ['km', 'meter', 'miles'];

  final List<String> processedFoods = ['Snacks', 'Ready Meals', 'Beverages'];
  final List<String> meats = ['Beef', 'Chicken', 'Poultry', 'Mutton'];
  final List<String> dairies = ['Milk', 'Cheese', 'Butter'];
  final List<String> grains = ['Rice', 'Wheat', 'Corn'];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double fontSize = MediaQuery.of(context).textScaleFactor * 16;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Checklist',
          style: TextStyle(fontSize: fontSize * 1.25),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.04),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Transportation',
                style: TextStyle(fontSize: fontSize * 1.25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height * 0.01),
              Text('Select transportation medium:', style: TextStyle(fontSize: fontSize)),
              DropdownButtonFormField<String>(
                value: selectedTransportMedium,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedTransportMedium = newValue!;
                  });
                },
                items: transportOptions.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option, style: TextStyle(fontSize: fontSize)),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Or enter your own',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
              ),
              SizedBox(height: height * 0.02),
              Text('Distance', style: TextStyle(fontSize: fontSize)),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Distance',
                        labelStyle: TextStyle(fontSize: fontSize),
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        distance = double.parse(value!);
                      },
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  DropdownButton<String>(
                    value: distanceUnit,
                    onChanged: (String? newValue) {
                      setState(() {
                        distanceUnit = newValue!;
                      });
                    },
                    items: distanceUnits.map((String unit) {
                      return DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit, style: TextStyle(fontSize: fontSize)),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Text('Mileage', style: TextStyle(fontSize: fontSize)),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mileage',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  mileage = double.parse(value!);
                },
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(height: height * 0.02),
              Text(
                'Track Your Food Habits',
                style: TextStyle(fontSize: fontSize * 1.25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height * 0.01),
              Text('Processed Food', style: TextStyle(fontSize: fontSize)),
              Column(
                children: processedFoods.map((String food) {
                  return RadioListTile<String>(
                    title: Text(food, style: TextStyle(fontSize: fontSize)),
                    value: food,
                    groupValue: selectedProcessedFood,
                    onChanged: (String? value) {
                      setState(() {
                        selectedProcessedFood = value!;
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: height * 0.02),
              Text('Meat', style: TextStyle(fontSize: fontSize)),
              Column(
                children: meats.map((String meat) {
                  return RadioListTile<String>(
                    title: Text(meat, style: TextStyle(fontSize: fontSize)),
                    value: meat,
                    groupValue: selectedMeat,
                    onChanged: (String? value) {
                      setState(() {
                        selectedMeat = value!;
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: height * 0.02),
              Text('Dairy', style: TextStyle(fontSize: fontSize)),
              Column(
                children: dairies.map((String dairy) {
                  return RadioListTile<String>(
                    title: Text(dairy, style: TextStyle(fontSize: fontSize)),
                    value: dairy,
                    groupValue: selectedDairy,
                    onChanged: (String? value) {
                      setState(() {
                        selectedDairy = value!;
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: height * 0.02),
              Text('Grains', style: TextStyle(fontSize: fontSize)),
              Column(
                children: grains.map((String grain) {
                  return RadioListTile<String>(
                    title: Text(grain, style: TextStyle(fontSize: fontSize)),
                    value: grain,
                    groupValue: selectedGrain,
                    onChanged: (String? value) {
                      setState(() {
                        selectedGrain = value!;
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: height * 0.02),
              Text(
                'Water Usage',
                style: TextStyle(fontSize: fontSize * 1.25, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Water usage (liters)',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  waterUsage = double.parse(value!);
                },
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(height: height * 0.02),
              Text(
                'Waste Recycling',
                style: TextStyle(fontSize: fontSize * 1.25, fontWeight: FontWeight.bold),
              ),
              Text('Recycled waste today?', style: TextStyle(fontSize: fontSize)),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('No', style: TextStyle(fontSize: fontSize)),
                      value: !recycledWaste,
                      onChanged: (bool? value) {
                        setState(() {
                          recycledWaste = !value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Yes', style: TextStyle(fontSize: fontSize)),
                      value: recycledWaste,
                      onChanged: (bool? value) {
                        setState(() {
                          recycledWaste = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              if (recycledWaste)
                ElevatedButton(
                  onPressed: () {
                    // Handle collecting recycle points
                  },
                  child: Text('Collect Recycle Points', style: TextStyle(fontSize: fontSize)),
                ),
              SizedBox(height: height * 0.02),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save the data and calculate carbon footprint
                    print('Transportation Medium: $selectedTransportMedium');
                    print('Distance: $distance $distanceUnit');
                    print('Mileage: $mileage');
                    print('Processed Food: $selectedProcessedFood');
                    print('Meat: $selectedMeat');
                    print('Dairy: $selectedDairy');
                    print('Grains: $selectedGrain');
                    print('Water Usage: $waterUsage liters');
                    print('Recycled Waste: $recycledWaste');
                  }
                },
                child: Text('Submit', style: TextStyle(fontSize: fontSize)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
