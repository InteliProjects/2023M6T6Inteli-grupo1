import 'package:flutter/material.dart';

class Escolas extends StatelessWidget {
  final String nome_escola;
  final String regiao;
  final String endereco;
  final String situacao_entrega;
  final String previsaoEntrega;
  final int quantidade_recebida;

  const Escolas({
    Key? key,
    required this.nome_escola,
    required this.regiao,
    required this.endereco,
    required this.situacao_entrega,
    required this.previsaoEntrega,
    required this.quantidade_recebida,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(nome_escola),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Região: $regiao'),
            Text('Endereço: $endereco'),
            Text('Situação da entrega: $situacao_entrega'),
            Text('Previsão de entrega: $previsaoEntrega'),
            Text('Tablets recebidos: $quantidade_recebida'),
          ],
        ),
      ),
      
    );
  }
}
