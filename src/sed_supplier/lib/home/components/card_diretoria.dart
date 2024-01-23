import 'package:flutter/material.dart';
import 'package:sed_supplier/criar_compra/criar_compra_entrega.dart';

class card_diretoria extends StatelessWidget {
  final int orderId;
  final String diretoriaNome;
  final String nomeItem;
  final int itensTotal;
  final int itensEntregues;

  card_diretoria({
    required this.orderId,
    required this.nomeItem,
    required this.diretoriaNome,
    required this.itensTotal,
    required this.itensEntregues,
  });

  @override
  Widget build(BuildContext context) {
        return InkWell(
      onTap: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroCompra(orderId: orderId, itemNome: nomeItem)));
      },
     child:Card(
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
                  diretoriaNome,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text('$itensTotal $nomeItem'),
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
                  '$itensEntregues / $itensTotal',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
