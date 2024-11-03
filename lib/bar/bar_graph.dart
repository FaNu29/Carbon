import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'bar_data.dart';

class CoBarGraph extends StatelessWidget {
  final List<double> weeklySummary;

  const CoBarGraph({Key? key, required this.weeklySummary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Assuming bar_data is a custom class you've defined elsewhere in your project
    // Initialize BarData
    bar_data myBarData = bar_data(
      sun_emission: weeklySummary[0],
      mon_emission: weeklySummary[1],
      tue_emission: weeklySummary[2],
      wed_emission: weeklySummary[3],
      thu_emission: weeklySummary[4],
      fri_emission: weeklySummary[5],
      sat_emission: weeklySummary[6],
    );
    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: SideTitles(showTitles: false),
          leftTitles: SideTitles(showTitles: false),
          rightTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            getTitles: (value) {
              switch (value.toInt()) {
                case 0:
                  return 'Sun';
                case 1:
                  return 'Mon';
                case 2:
                  return 'Tue';
                case 3:
                  return 'Wed';
                case 4:
                  return 'Thu';
                case 5:
                  return 'Fri';
                case 6:
                  return 'Sat';
                default:
                  return '';
              }
            },
          ),
        ),
        barGroups: myBarData.barData.map((data) => BarChartGroupData(
          x: data.x,
          barRods: [
            BarChartRodData(
              y: data.y,
              colors: [
                Theme.of(context).colorScheme.tertiary,
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.primary,
          ],

              width: 25,
              borderRadius: BorderRadius.circular(3),
              backDrawRodData: BackgroundBarChartRodData(
                show: true, // Ensure this is a boolean value
                colors: [Colors.white70], // Pass a list with the desired color
                y: 100,
              ),
            ),
          ],
        )).toList(),
      ),
    );
  }
}
