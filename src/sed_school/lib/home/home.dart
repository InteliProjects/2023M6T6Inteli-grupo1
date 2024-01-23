import 'package:flutter/material.dart';
import 'package:sed_school/componentes_globais/tituloSed.dart';
import 'package:sed_school/entrega/entrega.dart';
import 'package:sed_school/notificacoes/notifications.dart';
import 'package:sed_school/home/componentes/card_fornecedores.dart';
import 'package:sed_school/services/home_service.dart';
import 'package:intl/intl.dart';

// ... seu código continua aqui

class Fornecedor {
  final String shippingCompanyId;
  final String quantity;
  final String datinitialForecaste;
  final String finalForecast;
  final String numero_entrega;
  final String status_entrega;
  final String nome_escola;
  final String nome_item;
  final String id;


  Fornecedor(
      {required this.shippingCompanyId,
    required this.quantity,
    required this.datinitialForecaste,
    required this.finalForecast,
    required this.numero_entrega,
    required this.status_entrega,
    required this.nome_escola,
    required this.nome_item,
    required this.id,
  });

}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TituloSed(),
      
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Color.fromRGBO(38, 112, 232, 1),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Entregas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),

              FutureBuilder<List<dynamic>>(
  future: getCardHome(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      var jsonData = snapshot.data as List;
      List<Fornecedor> fornecedores = [];

      for (var data in jsonData) {
          // Analisa a string da data ISO 8601
             DateTime parsedDate = DateTime.parse(data["initialForecast"]);
             DateTime parsedDateFinal = DateTime.parse(data["finalForecast"]);
          // Formata a data para o formato desejado
          String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
          String formattedDateFinal = DateFormat('dd/MM/yyyy').format(parsedDateFinal);

          fornecedores.add(Fornecedor(
            shippingCompanyId: data['order']['supplier']['name'].toString(),
            quantity: data['quantity'].toString(),
            datinitialForecaste: formattedDate,
            numero_entrega:data['id'].toString(),
            status_entrega:data['statusId'].toString(),
            nome_escola:data['school']['name'].toString(),
            nome_item: data["order"]['itemName'].toString(),
            id:data['id'].toString(),
            finalForecast:formattedDateFinal

          ));
          
      }
      
      return Column(
        children: fornecedores.map((fornecedor) => CardFornecedor(
          title: fornecedor.shippingCompanyId, 
          subtitle: fornecedor.quantity, 
          trailing: fornecedor.datinitialForecaste,
          numero_entrega:fornecedor.numero_entrega,
          status_entrega:fornecedor.status_entrega,
          nome_escola:fornecedor.nome_escola,
          nome_item: fornecedor.nome_item,
          id:fornecedor.id,
          finalForecast:fornecedor.finalForecast
        )).toList(),
      );
    } else if (snapshot.hasError) {
      return Text("Error: ${snapshot.error}");
    } else {
      return const CircularProgressIndicator();
    }
  },
)
            
          ],
        ),
      ),
    );
  }
}