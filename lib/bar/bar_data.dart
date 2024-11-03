import 'package:carbon/bar/weekly_emission.dart';

class bar_data {
  final double sun_emission;
  final double mon_emission;
  final double tue_emission;
  final double wed_emission;
  final double thu_emission;
  final double fri_emission;
  final double sat_emission;

  bar_data({
    required this.sun_emission,
    required this.mon_emission,
    required this.tue_emission,
    required this.wed_emission,
    required this.thu_emission,
    required this.fri_emission,
    required this.sat_emission,
  });

  List<weekly_emission>barData = [];

  //initialize bar_data
  void initializeBarData() {
    barData = [
      weekly_emission(x: 0, y: sun_emission), // Sunday
      weekly_emission(x: 1, y: mon_emission), // Monday
      weekly_emission(x: 2, y: tue_emission), // Tuesday
      weekly_emission(x: 3, y: wed_emission), // Wednesday
      weekly_emission(x: 4, y: thu_emission), // Thursday
      weekly_emission(x: 5, y: fri_emission), // Friday
      weekly_emission(x: 6, y: sat_emission), // Saturday
    ];
  }



}