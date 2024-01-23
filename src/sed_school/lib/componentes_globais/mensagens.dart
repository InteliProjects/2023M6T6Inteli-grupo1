
import 'package:flutter/material.dart';

class ReceivedMessage extends StatelessWidget {
  final String message;
  final bool isCompleted;

  const ReceivedMessage({
    required this.message,
    this.isCompleted = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (isCompleted) ...[
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.check, color: Colors.green),
            ),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isCompleted ? Colors.green[100] : Colors.blue[100],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                message,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}