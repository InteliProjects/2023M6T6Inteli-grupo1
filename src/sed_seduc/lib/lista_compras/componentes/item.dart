import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final String nome_item;
  final int quantidade;
  final String fornecedor;

  const Item({
    Key? key,
    required this.nome_item,
    required this.quantidade,
    required this.fornecedor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(nome_item),
      subtitle: Text('$quantidade unidades'),
      trailing: Text(fornecedor),
    );
  }
}
