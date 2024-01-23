
import 'package:flutter/material.dart';
import 'package:sed_school/componentes_globais/tituloSed.dart';
import 'package:sed_school/home/home.dart';
import 'package:sed_school/notificacoes/notifications.dart';
import 'package:sed_school/review.dart';
import 'package:sed_school/componentes_globais/mensagens.dart';
import 'package:sed_school/componentes_globais/menu_dropdown.dart';
import 'package:sed_school/services/status_pedido.dart';
import 'package:intl/intl.dart';

class Message {
  final String next_status_id;
  final String moment;
  final bool entregue;



  Message(
      {required this.next_status_id,
    required this.moment,
    required this.entregue

  });

}


class DetailsScreen extends StatelessWidget {
  final String numero_entrega;
  final String status_entrega;
  final String nome_escola;
  final String nome_item;
  final String quantidade;
  final String id;
  const DetailsScreen({required this.numero_entrega,required this.status_entrega,required this.nome_escola,required this.nome_item,required this.quantidade,required this.id,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String status_titulo=status_entrega;
    
    if (status_titulo=="COMPLETED"){
        status_titulo="ENTREGUE";
    }else{
      status_titulo="EM TRÂNSITO";
    };

    print(status_titulo);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TituloSed(),

        actions: [
          const MenuHamburguer(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
  padding: const EdgeInsets.all(8.0),
  margin: const EdgeInsets.all(10.0), // Adjust the margin as needed
  decoration: BoxDecoration(
    color: Colors.blue, // Replace with the exact color code you want
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 3,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  ),
  child: Text(
    'Entrega # $numero_entrega - $status_titulo',
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white, // Set text color to contrast with the blue background
    ),
  ),
),

Container(
  padding: const EdgeInsets.all(8.0),
  margin: const EdgeInsets.all(10.0), // Adjust the margin as needed
  decoration: BoxDecoration(
    color: Colors.blue, // Replace with the exact color code you want
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 3,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  ),
  child: Text(
    '$nome_escola - $quantidade $nome_item',
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white, // Set text color to contrast with the blue background
    ),
  ),
),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Acompanhamento do processo',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(32, 112, 232, 1)),
            ),
          ),
          Expanded(
            child: ListView(
              children:  <Widget>[
                SizedBox(height: 8),

              
              
          FutureBuilder<List<dynamic>>(
              future: getStatusPedido(id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var jsonData = snapshot.data as List;
                  List<Message> messages = [];

                      for (var data in jsonData) {
                          DateTime parsedDate = DateTime.parse(data["moment"]);
                          String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
                          
                            String status_notificacao = data["next_status_id"].toString();
                            String status;

                            if (status_notificacao == 'COMPLETED') {
                              status = 'ENTREGUE DIA: $formattedDate';
                            } else if (status_notificacao == 'SEPARATED') {
                              status = 'SEPARADO PARA ENTREGA DIA: $formattedDate';
                            } else if (status_notificacao == 'CREATED') {
                              status = 'POSTADO DIA: $formattedDate';
                            } else if (status_notificacao == 'DELIVERY') {
                              status = 'SEU PEDIDO SAIU PARA ENTREGA DIA: $formattedDate';
                            } else {
                              status = status_notificacao;
                            }
                          bool true_false=status_notificacao=='COMPLETED';
                
                          messages.add(Message(
                            next_status_id: status,
                            moment: formattedDate,
                            entregue: true_false
                          ));
                          
                      }
                      
                        List<Widget> messageWidgets = messages
                        .map((message) => [
                              SizedBox(height: 8), // Espaço entre os cards
                              ReceivedMessage(
                                message: message.next_status_id,
                                isCompleted: message.entregue,
                              ),
                            ])
                        .expand((element) => element)
                        .toList();

                          return Column(children: messageWidgets);
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          return const CircularProgressIndicator();
                        }
                  }),
              

              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewScreen(id: id),
                  ),
                );
              },
              child: const Text(
                'Entregue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(38, 112, 232, 1)),
            ),
          ),
        ],
      ),
    );
  }
}


