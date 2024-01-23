import 'package:flutter/material.dart';

class EscolaCard extends StatelessWidget {
  final String cie;
  final String regiao;
  final String endereco;
  final String status;
  final String previsaoEntrega;
  final String quantidadeTotal;
  final String item;

  const EscolaCard({
    required this.cie,
    required this.regiao,
    required this.endereco,
    required this.status,
    required this.previsaoEntrega,
    required this.quantidadeTotal,
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('$regiao - $cie'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(endereco),
            Text('Previsão de entrega: $previsaoEntrega'),
            Text('Status: $status'),
            Text('$item recebidos: $quantidadeTotal'),
          ],
        ),
      ),
    );
  }
}
