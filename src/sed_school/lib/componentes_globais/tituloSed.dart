import 'package:flutter/material.dart';

class TituloSed extends StatelessWidget {
  const TituloSed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'S',
            style: TextStyle(
                color: Color.fromRGBO(38, 112, 232, 1),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'E',
            style: TextStyle(
                color: Color.fromRGBO(242, 217, 23, 1),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'D',
            style: TextStyle(
                color: Color.fromRGBO(37, 211, 102, 1),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
