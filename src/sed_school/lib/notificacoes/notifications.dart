import 'package:flutter/material.dart';
import 'package:sed_school/componentes_globais/tituloSed.dart';
import 'package:sed_school/home/home.dart';
import 'package:sed_school/review.dart';
import 'package:sed_school/componentes_globais/mensagens.dart';
import 'package:sed_school/notificacoes/componentes/lista_notificacao.dart';
import 'package:sed_school/notificacoes/componentes/secao_data.dart';
import 'package:sed_school/services/notificacao_service.dart';
import 'package:intl/intl.dart';

class Message {
  final String status;
  final String deliveryId;

  Message(
    {
      required this.deliveryId,
      required this.status
    }
  );
}

class Notificacao {
  final String date;
  final List<Message> messages;

  Notificacao(
      {required this.date,
      required this.messages

  });
}

String formatStatus(String statusNotification, String formattedDate) {
  switch (statusNotification) {
    case 'COMPLETED':
      return 'ENTREGUE';
    case 'SEPARATED':
      return 'SEPARADO PARA ENTREGA';
    case 'CREATED':
      return 'POSTADO';
    case 'DELIVERY':
      return 'SEU PEDIDO SAIU PARA ENTREGA';
    default:
      return statusNotification;
  }
}

class ListTileApp extends StatelessWidget {
  const ListTileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const NotificationScreen(),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TituloSed(),
        leading: IconButton(
          icon: const Icon(
            Icons.home,
            color: Color.fromRGBO(38, 112, 232, 1),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Color.fromRGBO(38, 112, 232, 1),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          // Set the height to the viewport height, you can adjust this as needed
          height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding:  EdgeInsets.all(8.0),
            child: Text(
              'Notificações',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child:FutureBuilder<List<dynamic>>(
          future: getCardNotificacao(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var jsonData = snapshot.data as List;
              List<Notificacao> notificacoes = [];
              List<Widget> widgets = [];

              for (var data in jsonData) {
                  // Analisa a string da data ISO 8601
                  DateTime parsedDate = DateTime.parse(data["date"]);
                  // Formata a data para o formato desejado
                  String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
                  List<Message> messages = [];
                  for(var notifications in data['notifications']){
                     String status = formatStatus(notifications['status'], formattedDate);
                    messages.add(Message(
                      status: status,
                      deliveryId: notifications['deliveryId'].toString()
                    ));
                  }
                  notificacoes.add(Notificacao(
                    date: formattedDate,
                    messages: messages
                  )); 
              }
             for (var tituloData in notificacoes) {
                          widgets.add(const Divider());
                          widgets.add(SecaoData(data: tituloData.date));

                            List<ReceivedMessage> receivedMessages = tituloData.messages.map((message) => 


                              ReceivedMessage(

                                message: 'Entrega #${message.deliveryId} - ${message.status}',
                                isCompleted: message.status.startsWith('ENTREGUE'),
                              )
                            ).toList();

                            widgets.add(ListaNotificacoes(
                              messages: receivedMessages,
                            ));
                }

                return Column(
                  children: widgets,
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
            ),
          ),
        ],
      ),)),
      );
  }
}

