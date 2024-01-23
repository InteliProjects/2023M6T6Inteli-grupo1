import 'package:flutter/material.dart';
import 'package:sed_supplier/cadastro/cadastro.dart';
import 'package:sed_supplier/criar_compra/criar_compra_entrega.dart';
import 'package:sed_supplier/home/home.dart';
import 'listagem_escolas/listagem_escolas.dart';
import 'listagem_entregas/listagem_entregas.dart';

import 'login/login.dart';

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
        '/listagem_entregas': (context) => lista_entregas(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => home(),
        '/cadastro': (context) => Cadastro(),

      },
    );
  }
}
