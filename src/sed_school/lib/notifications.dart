import 'package:flutter/material.dart';
import 'package:sed_school/home/home.dart';

void main() => runApp(const ListTileApp());

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
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'S',
                style: TextStyle(
                    color: Color.fromRGBO(38, 112, 232, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'E',
                style: TextStyle(
                    color: Color.fromRGBO(242, 217, 23, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'D',
                style: TextStyle(
                    color: Color.fromRGBO(37, 211, 102, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Notificações',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '12/10/2023',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(32, 112, 232, 1)),
            ),
          ),
          Expanded(
            child: ListView(
              children: const <Widget>[
                SizedBox(height: 8),
                ReceivedMessage(message: 'Entrega #1235 criada por Positivo'),
                SizedBox(height: 8),
                ReceivedMessage(message: 'Entrega #1235 criada por Positivo'),
                SizedBox(height: 8),
                ReceivedMessage(
                  message: 'Entrega #1101 - Positivo - Sul II foi concluída',
                  isCompleted: true,
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '12/10/2023',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(32, 112, 232, 1)),
            ),
          ),
          Expanded(
            child: ListView(
              children: const <Widget>[
                SizedBox(height: 8),
                ReceivedMessage(message: 'Entrega #1236 criada por Positivo'),
                SizedBox(height: 8),
                ReceivedMessage(message: 'Entrega #1235 criada por Positivo'),
                SizedBox(height: 8),
                ReceivedMessage(
                  message:
                      'Entrega #1100 - foi avaliada e apresentou problemas',
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '12/10/2023',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(32, 112, 232, 1)),
            ),
          ),
          Expanded(
            child: ListView(
              children: const <Widget>[
                SizedBox(height: 8),
                ReceivedMessage(message: 'Entrega #1236 criada por Positivo'),
                SizedBox(height: 8),
                ReceivedMessage(message: 'Entrega #1235 criada por Positivo'),
                SizedBox(height: 8),
                ReceivedMessage(
                  message:
                      'Entrega #1100 - foi avaliada e apresentou problemas',
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReceivedMessage extends StatelessWidget {
  final String message;
  final bool isCompleted;

  const ReceivedMessage({
    required this.message,
    this.isCompleted = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (isCompleted) ...[
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.check, color: Colors.green),
            ),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isCompleted ? Colors.green[100] : Colors.blue[100],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                message,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
