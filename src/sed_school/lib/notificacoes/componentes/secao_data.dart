import 'package:flutter/material.dart';

class SecaoData extends StatelessWidget {
  final String data;

  const SecaoData({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        data,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(32, 112, 232, 1),
        ),
      ),
    );
  }
}
