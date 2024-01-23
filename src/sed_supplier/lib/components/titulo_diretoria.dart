import 'package:flutter/material.dart';

class titulo_diretoria extends StatelessWidget {
  final String diretoria;

  const titulo_diretoria({Key? key, required this.diretoria}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Text(
        diretoria,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }
}
