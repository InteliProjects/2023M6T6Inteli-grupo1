import 'package:flutter/material.dart';
import 'package:renan_s_application8/presentation/mockup_entrega_screen/mockup_entrega_screen.dart';

class DeliveryIDScreen extends StatefulWidget {
  DeliveryIDScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryIDScreen> createState() => _DeliveryIDScreenState();
}

class _DeliveryIDScreenState extends State<DeliveryIDScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informe o ID da Entrega'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Ex: 9",
                labelText: 'ID da Entrega',
                border: OutlineInputBorder(),
              ),
              controller: controller,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String deliveryID = controller.text;

                String? parsedID = deliveryID;

                if (parsedID.isEmpty == false) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MockupEntregaScreen(parsedID: parsedID),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Erro'),
                        content: Text(
                            'Por favor, insira um número válido para o ID da entrega.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Confirmar', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
