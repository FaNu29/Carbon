import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CategoryPieChart extends StatelessWidget {
  final Map<String, double> data;

  const CategoryPieChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections = data.entries.map((entry) {
      return PieChartSectionData(
        color: _getColorForCategory(entry.key),
        value: entry.value,
        title: '${entry.value}%',
        radius: 100, // Increase radius for a larger pie chart
        titleStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return Expanded(
      child: Row(
        children: [
          // Pie chart section occupying 2/3 of the screen
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: PieChart(
                PieChartData(
                  sections: sections,
                  centerSpaceRadius: 0,
                  sectionsSpace: 2,
                  borderData: FlBorderData(show: false),
                  pieTouchData: PieTouchData(enabled: false),
                ),
              ),
            ),
          ),

          // Legend section in a separate column on the right
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: data.keys.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 16,
                          color: _getColorForCategory(category),
                        ),
                        SizedBox(width: 1),
                        Text(
                          category,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForCategory(String category) {
    switch (category) {
      case 'food':
        return Colors.green;
      case 'electricity':
        return Colors.blue;
      case 'transportation':
        return Colors.orange;
      case 'waste':
        return Colors.red;
      case 'consumption':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
