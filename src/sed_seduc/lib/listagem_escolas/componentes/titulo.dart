import 'package:flutter/material.dart';

class Titulo extends StatelessWidget {
  final String name;
  final int entregue;
  final int total;

  const Titulo({
    required this.name,
    required this.entregue,
    required this.total,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'Entregues/total: $entregue/$total',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
