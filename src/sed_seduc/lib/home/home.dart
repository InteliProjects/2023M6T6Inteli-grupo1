import 'package:flutter/material.dart';
import '../serviço/api_service.dart';
import '/home/components/resumo.dart';
import '/home/components/diretoria.dart';
import '/menu/menu.dart';
import './components/sedName.dart';

class home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<home> {
  final ApiService apiService = ApiService(baseUrl: 'http://34.224.239.245');
  late List<Map<String, dynamic>> orders = [];
  late List<Map<String, dynamic>> deliveries = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      orders = await apiService.fetchOrders();
      deliveries = await apiService.fetchDeliveries();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Acompanhamento de entregas'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.notifications,
            color: Color.fromRGBO(38, 112, 232, 1),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("/notificacoes");
          },
        ),
        actions: <Widget>[
          Menu(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 44.0, bottom: 16.0),
                child: Center(child: sedName()),
              ),
              Text(
                'Acompanhamento de entregas',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              ResumoProgressBar(
                title: 'Entregas Recebidas',
                value: deliveries.isNotEmpty
                    ? deliveries
                        .where(
                            (delivery) => delivery['statusId'] == 'COMPLETED')
                        .length
                        .toDouble()
                    : 0,
                maxValue:
                    deliveries.isNotEmpty ? deliveries.length.toDouble() : 1,
              ),
              ResumoProgressBar(
                title: 'Enviados para transportadora',
                value: deliveries.isNotEmpty
                    ? deliveries
                        .where((delivery) => delivery['statusId'] == 'SHIPPED')
                        .length
                        .toDouble()
                    : 0,
                maxValue:
                    deliveries.isNotEmpty ? deliveries.length.toDouble() : 1,
              ),
              Text(
                'Quantidade de produtos recebidos por escola',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 120,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Diretoria(
                        title: 'Sul',
                        quantity: '50.000',
                      ),
                      Diretoria(
                        title: 'Norte',
                        quantity: '50.000',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed("/cadastarEntrega");
                },
                child: Text('Criar Pedido'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
