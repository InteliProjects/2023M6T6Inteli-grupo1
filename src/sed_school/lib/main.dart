import 'package:flutter/material.dart';
import 'package:sed_school/notificacoes/notifications.dart';
import '/home/home.dart';
import 'login/login.dart'; // Importe a sua nova página




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/notificacoes': (context) => const NotificationScreen(),
      },
    );
  }
}
