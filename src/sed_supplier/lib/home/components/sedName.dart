import 'package:flutter/material.dart';

class sedName extends StatelessWidget {
  const sedName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.transparent, // Text Color
        backgroundColor: Colors.transparent, // Button Color
        onSurface: Colors.transparent, // Splash Color
      ),
      onPressed: () {
        Navigator.of(context).pushReplacementNamed("/home");
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'S',
            style: TextStyle(
              fontSize: 50.0,
              color: Color.fromRGBO(38, 112, 232, 1),
              fontFamily: 'YourFontFamily', // Replace with your actual font family
            ),
          ),
          Text(
            'E',
            style: TextStyle(
              fontSize: 50.0,
              color: Color.fromRGBO(37, 211, 102, 1),
              fontFamily: 'YourFontFamily', // Replace with your actual font family
            ),
          ),
          Text(
            'D',
            style: TextStyle(
              fontSize: 50.0,
              color: Color.fromRGBO(242, 227, 23, 1),
              fontFamily: 'YourFontFamily', // Replace with your actual font family
            ),
          ),
        ],
      ),
    );
  }
}
