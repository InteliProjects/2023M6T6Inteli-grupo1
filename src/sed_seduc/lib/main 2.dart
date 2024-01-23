import 'package:flutter/material.dart';
import '/criar_entrega/criar_entrega.dart';
import '/home/home.dart';
import 'login/login.dart'; // Importe a sua nova página
import 'listagem/listagem.dart'; // Importe a sua nova página
import 'listagem_escolas/listagem_escolas.dart';
import 'lista_compras/lista_compras.dart';
import 'editar_entrega/editar_entrega.dart';
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
      initialRoute: '/home',
      routes: {
        '/login': (context) =>  login_escola(),
        '/home': (context) =>  home(),
        '/lista': (context) => listagem(),
        '/cadastarEntrega': (context) =>   CadastroEntregaScreen(),
        '/listagemEscolas': (context) =>   listagem_escolas(),
        '/listagemCompras':(context)=>lista_compras(),
        '/editar_entrega':(context)=>editar_entrega(),
        // '/entregaEscola': (context) =>   const entregaEscola(),
        // '/confirmarEntrega': (context) =>    ConfirmarEntrega(),
        // '/confirmarCodigo': (context) =>    confirmarCodigo(),
      },
    );
  }
}
