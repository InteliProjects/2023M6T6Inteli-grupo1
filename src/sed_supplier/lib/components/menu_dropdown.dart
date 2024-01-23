import 'package:flutter/material.dart';
import 'package:sed_supplier/home/home.dart';
import 'package:sed_supplier/listagem_entregas/listagem_entregas.dart';


class MenuHamburguer extends StatelessWidget {
  const MenuHamburguer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String result) {
          switch (result) {
          case 'opcao1':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => home()), // Substitua `Home()` pela sua página de início
            );
            break;
          case 'opcao2':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => lista_entregas()), // Substitua `Notifications()` pela sua página de notificações
            );
            break;
          // Adicione mais casos se tiver mais opções
        }
          
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'opcao1',
          child: Text('Home'),
        ),
        const PopupMenuItem<String>(
          value: 'opcao2',
          child: Text('Lista Entregas'),
        ),

        
      ],
      icon: const Icon(Icons.menu), // Ícone de menu hambúrguer
    );
  }
}
