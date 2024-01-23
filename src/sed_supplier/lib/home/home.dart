import 'package:flutter/material.dart';
import 'package:sed_supplier/components/menu_dropdown.dart';
import 'package:sed_supplier/home/components/card_diretoria.dart';
import 'package:sed_supplier/home/components/card_transportadora.dart';
import 'package:sed_supplier/services/home_service.dart';
import 'components/sedName.dart';

class Order {
  final int idOrder;
  final String trasnsportadoraName;
  final int quantityTotal;
  final int quantityDelivered;
  final String itemName;

  Order(
      {required this.idOrder,
    required this.trasnsportadoraName,
    required this.quantityTotal,
    required this.quantityDelivered,
    required this.itemName,
  });
}

class School {
  final int idOrder;
  final String schoolName;
  final int quantityTotal;
  final int quantityDelivered;
  final String itemName;

  School(
      {required this.idOrder,
    required this.schoolName,
    required this.quantityTotal,
    required this.quantityDelivered,
    required this.itemName,
  });
}

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const MenuHamburguer()
        ],
        title: Text(''), // Deixe o title vazio
      ),
      body: SingleChildScrollView(
       child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              // Adicione o componente sedName aqui
              child: sedName(),
            ),
            // Espaço em branco
            SizedBox(height: 8),

            // Texto "Transportadora"
            Text(
              'Transportadora',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // Espaço em branco
            SizedBox(height: 8),

            FutureBuilder<List<dynamic>>(
              future: getListCardHome(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var jsonData = snapshot.data as List;
                  List<Order> orders = [];

                  for (var data in jsonData) {
                    Map totalQuantities = data['totalQuantities'];
                    Map deliveredQuantities = data['deliveredQuantities'];

                    totalQuantities.forEach((shippingCompanyId, quantity) {
                      int deliveredQuantity = deliveredQuantities[shippingCompanyId] ?? 0;

                      orders.add(Order(
                        idOrder: data['id'],
                        trasnsportadoraName: shippingCompanyId.toString(),
                        quantityTotal: quantity,
                        quantityDelivered: deliveredQuantity,
                        itemName: data['itemName'].toString() 
                      ));
                    });
                  }

                  return Column(
                    children: orders.map<Widget>((order) {
                      return Column(
                        children: [
                          card_transportadora(
                            orderId: order.idOrder,
                            itemNome: order.itemName,
                            quantidadeItensTotal: order.quantityTotal,
                            transportadoraNome: order.trasnsportadoraName,
                            quantidadeItensEntregues: order.quantityDelivered,
                          ),
                          SizedBox(height: 16), // Espaço de 16 pixels
                        ],
                      );
                    }).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            // Espaço em branco
            SizedBox(height: 20),

            // Texto "Diretorias"
            Text(
              'Diretorias',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // Espaço em branco
            SizedBox(height: 8),
              FutureBuilder<List<dynamic>>(
                future: getListBySchool(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var jsonData = snapshot.data as List;
                    List<School> schools = [];

                    for (var orderData in jsonData) {
                      List schoolsData = orderData['schools'];

                      for (var schoolData in schoolsData) {
                        schools.add(School(
                          idOrder: orderData['orderId'],
                          schoolName: schoolData['schoolName'],
                          quantityTotal: schoolData['totalQuantity'],
                          quantityDelivered: schoolData['deliveredQuantity'],
                          itemName: orderData['itemName']
                        ));
                      }
                    }

                    return Column(
                      children: schools.map<Widget>((school) {
                        return Column(
                          children: [
                            card_diretoria(
                              orderId: school.idOrder,
                              nomeItem: school.itemName,
                              itensTotal: school.quantityTotal,
                              diretoriaNome: school.schoolName,
                              itensEntregues: school.quantityDelivered,
                            ),
                            SizedBox(height: 16), // Espaço de 16 pixels
                          ],
                        );
                      }).toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
          ],
        ),
      ),
    ));
  }
}
