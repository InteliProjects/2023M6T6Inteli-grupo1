import 'package:flutter/material.dart';

class ResumoProgressBar extends StatelessWidget {
  final String title;
  final double value;
  final double maxValue;

  ResumoProgressBar({
    required this.title,
    required this.value,
    required this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the progress percentage and determine the color
    final progress = value / maxValue;
    final color =
        ColorTween(begin: Colors.red, end: Colors.green).lerp(progress);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title
        Text(title),
        SizedBox(width: 8), // You can adjust the spacing as needed

        // Progress Bar
        Expanded(
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade300, // Background color
            valueColor: AlwaysStoppedAnimation<Color?>(color),
            minHeight: 15, // You can adjust the height as needed
          ),
        ),

        // Progress Text
        SizedBox(width: 8), // Spacing between the bar and the text
        Text('${value.toInt()}/$maxValue'),
      ],
    );
  }
}
