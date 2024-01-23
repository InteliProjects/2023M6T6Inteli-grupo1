import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String result) { // aqui serao definidas as rotas a serem enviadas dependendo de qual item do menu o usuario clicar
        switch (result) {
          case 'home':
            Navigator.pushNamed(context, '/home');
            break;
          case 'fornecedores':
            Navigator.pushNamed(context, '/lista');
            break;
          case 'diretorias':
            Navigator.pushNamed(context, '/listagemEscolas');
            break;
          case 'compras':
            Navigator.pushNamed(context, '/listagemCompras');
            break;
          case 'editar_compras':
            Navigator.pushNamed(context, '/editar_entrega');
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(//aqui vamos definir o nome no botao e o valor que ele vai receber para enviar paras as rotas que definimos acima
          value: 'home',
          child: Text('Home'),
        ),
        const PopupMenuItem<String>(
          value: 'fornecedores',
          child: Text('Fornecedores'),
        ),
        const PopupMenuItem<String>(
          value: 'diretorias',
          child: Text('Diretorias'),
        ),
        const PopupMenuItem<String>(
          value: 'compras',
          child: Text('Compras'),
        ),
        const PopupMenuItem<String>(
          value: 'editar_compras',
          child: Text('Editar Compra'),
        ),
      ],
      icon: Icon(Icons.menu), // icon for menu, change it as needed
    );
  }
}
