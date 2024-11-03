import 'package:flutter/material.dart';

class ArcProgressBar extends StatelessWidget {
  final double value;
  final double maxValue;
  final Color progressColor;
  final Color backgroundColor;
  final TextStyle textStyle;
  final String text1;
  final String text2;
  final String text;
  final TextStyle textStyleLabel;

  const ArcProgressBar({
    Key? key,
    required this.value,
    required this.maxValue,
    required this.progressColor,
    required this.backgroundColor,
    required this.textStyle,
    required this.text1,
    required this.text2,
    required this.text,
    required this.textStyleLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(300, 200), // Adjust size as needed
      painter: ArcPainter(
        value: value,
        maxValue: maxValue,
        progressColor: progressColor,
        backgroundColor: backgroundColor,
      ),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text1,
              style: textStyleLabel,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${value.toStringAsFixed(0)}',
                  style: textStyle,
                ),
                SizedBox(width: 5),
                Text(
                  text2,
                  style: textStyleLabel,
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: textStyleLabel,
            ),
          ],
        ),
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final double value;
  final double maxValue;
  final Color progressColor;
  final Color backgroundColor;

  ArcPainter({
    required this.value,
    required this.maxValue,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 30
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = 25
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final double startAngle = -3.14; // Start from the left
    final double sweepAngle = 3.14 * (value / maxValue); // Sweep based on the value

    canvas.drawArc(rect, startAngle, 3.14, false, backgroundPaint);
    canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
