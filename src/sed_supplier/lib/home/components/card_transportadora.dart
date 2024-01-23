import 'package:flutter/material.dart';
import 'package:sed_supplier/criar_compra/criar_compra_entrega.dart';

class card_transportadora extends StatelessWidget {
  final int orderId;
  final String transportadoraNome;
  final String itemNome;
  final int quantidadeItensTotal;
  final int quantidadeItensEntregues;

  card_transportadora({
    required this.orderId,
    required this.itemNome,
    required this.transportadoraNome,
    required this.quantidadeItensTotal,
    required this.quantidadeItensEntregues,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroCompra(orderId: orderId, itemNome: itemNome)));
      },
      child: Card(
        elevation: 2.0,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Parte da esquerda
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transportadoraNome,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text('$quantidadeItensTotal $itemNome'),
                  SizedBox(height: 8.0)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Entregue / Total:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$quantidadeItensEntregues / $quantidadeItensTotal',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
