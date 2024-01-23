import 'package:flutter/material.dart';
import '/lista_compras/componentes/item.dart'; // Atualize com o caminho correto
import '/menu/menu.dart';
import '../serviço/api_service.dart';

class lista_compras extends StatefulWidget {
  @override
  _ListaComprasState createState() => _ListaComprasState();
}

class _ListaComprasState extends State<lista_compras> {
  final ApiService apiService = ApiService(baseUrl: 'http://34.224.239.245');
  late List<Map<String, dynamic>> orders = [];
  late List<Map<String, dynamic>> suppliers = [];
  String? selectedItemFilter;
  String? selectedSupplierFilter;

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      orders = await apiService.fetchOrders();
      suppliers = await apiService.fetchSuppliers();
      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  String getSupplierNameById(String id) {
    return suppliers
        .firstWhere((supplier) => supplier['id'].toString() == id,
            orElse: () => {'name': 'Unknown'})['name']
        .toString();
  }

  List<Map<String, dynamic>> mapOrdersToNames(
      List<Map<String, dynamic>> orders) {
    return orders.map((order) {
      return {
        'itemName': order['itemName'],
        'quantity': order['quantity'],
        'supplierName': getSupplierNameById(order['supplierId'].toString()),
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredOrders = mapOrdersToNames(orders);

    if (selectedItemFilter != null) {
      filteredOrders = filteredOrders
          .where((order) => order['itemName'] == selectedItemFilter)
          .toList();
    }

    if (selectedSupplierFilter != null) {
      filteredOrders = filteredOrders
          .where((order) =>
              order['supplierName'].toString() == selectedSupplierFilter)
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
        centerTitle: true,
        actions: <Widget>[
          Menu(),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              hint: Text('Item'),
              items: orders
                  .map((order) => order['itemName'].toString())
                  .toSet()
                  .toList()
                  .map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedItemFilter = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButtonFormField<String>(
              hint: Text('Fornecedor'),
              items: suppliers
                  .map((supplier) => supplier['name'].toString())
                  .toSet()
                  .toList()
                  .map((supplier) {
                return DropdownMenuItem<String>(
                  value: supplier,
                  child: Text(supplier),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSupplierFilter = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                return Item(
                  nome_item: filteredOrders[index]['itemName'],
                  quantidade: filteredOrders[index]['quantity'],
                  fornecedor: filteredOrders[index]['supplierName'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
