import 'package:flutter/material.dart';
import 'package:sed_supplier/services/delivery_service.dart';
import '/components/sedName.dart';
import '/components/card_entregas.dart';
import 'package:sed_supplier/components/menu_dropdown.dart';

class Delivery {
  final String idDelivery;
  final String itenName;
  final int quantity;
  final String shippingCompanyName;
  final bool isChecked;
  final String schoolName;

  Delivery(
      {required this.itenName,
    required this.idDelivery,
    required this.quantity,
    required this.shippingCompanyName,
    required this.isChecked,
    required this.schoolName
   
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: lista_entregas(),
    );
  }
}

class lista_entregas extends StatelessWidget {
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  String? dropdownItemValue;
  String? categoryDropdownValue;
  String? supplierDropdownValue;

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
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: sedName(),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          items: ['Escola 1', 'Escola 2', 'Escola 3']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: 'Escola',
                            contentPadding: EdgeInsets.all(16),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 21, 91, 203),
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 21, 91, 203),
                                width: 2.0,
                              ),
                            ),
                          ),
                          value: categoryDropdownValue,
                          onChanged: (String? newValue) {
                            categoryDropdownValue = newValue;
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          items: [
                            'Fornecedor 1',
                            'Fornecedor 2',
                            'Fornecedor 3'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: 'Fornecedor',
                            contentPadding: EdgeInsets.all(16),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 21, 91, 203),
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 21, 91, 203),
                                width: 2.0,
                              ),
                            ),
                          ),
                          value: supplierDropdownValue,
                          onChanged: (String? newValue) {
                            supplierDropdownValue = newValue;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica de pesquisa aqui
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 21, 91, 203),
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    ),
                    child: Text(
                      'Pesquisar',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 16),
                   FutureBuilder<List<dynamic>>(
                    future: getListCardSupplier(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var jsonData = snapshot.data as List;
                        List<Delivery> deliverys = [];
                  
                        for (var data in jsonData) {
                          String statusNotificacao = data['statusId'].toString();
                          bool isChecked = statusNotificacao == 'COMPLETED';
                  
                            deliverys.add(Delivery(
                              idDelivery: data['id'].toString(),
                              itenName: data['order']['itemName'].toString(),
                              isChecked: isChecked,
                              shippingCompanyName: data['shippingCompany']['name'].toString(),
                              quantity: data['quantity'],
                              schoolName: data['school']['name'].toString(),
                            ));
                        }
                        
                        return Column(
                    children: deliverys.map<Widget>((delivery) {
                      return Column(
                        children: [
                          card_entrega(
                            itemName: delivery.itenName,
                            quantity: delivery.quantity,
                            supplierName: delivery.shippingCompanyName,
                            isChecked: delivery.isChecked,
                            schoolName: delivery.schoolName,
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
