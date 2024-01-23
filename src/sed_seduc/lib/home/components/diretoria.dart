import 'package:flutter/material.dart';

class Diretoria extends StatelessWidget {
  final String title;
  final String quantity;

  Diretoria({required this.title, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(right: 16), // Add margin for spacing between items
      decoration: BoxDecoration(
        color: Colors.blue, // Set the background color to blue
        borderRadius: BorderRadius.circular(8), // Optional: if you want rounded corners
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(quantity, style: TextStyle(color: Colors.white)),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/listagemEscolas"); 
            },
            child: Text('Acessar escola', style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero, // Remove padding if needed
            ),
          ),
        ],
      ),
    );
  }
}
