import 'package:flutter/material.dart';
import 'componentes/titulo.dart';
import 'componentes/escolas.dart';
import '../home/components/sedName.dart'; // Make sure the path is correct
import '/menu/Menu.dart'; // Import the menu component

class listagem extends StatelessWidget {
  const listagem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Fornecedores'),
        centerTitle: true,
        actions: <Widget>[
          Menu(), // Add the menu component here as an action
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 44.0, bottom: 16.0),
            child: Center(child: sedName()), // Your custom centered widget, now centered
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                Titulo(name: 'Dell', entregue: 100, total: 200),
                EscolaCard(
                  cie: "15",
                  regiao: 'São Paulo / Metropolitana',
                  endereco: 'Rua dos Estudantes, 123',
                  status: 'Em trânsito',
                  previsaoEntrega: 'Previsão de entrega 22/03/2023',
                  quantidadeTotal: "200",
                  item: "Tablets",
                ),
                // Add more EscolaCard widgets as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
