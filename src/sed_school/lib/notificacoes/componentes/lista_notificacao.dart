import 'package:flutter/material.dart';
import 'package:sed_school/componentes_globais/mensagens.dart';

class ListaNotificacoes extends StatelessWidget {
  final List<ReceivedMessage> messages;

  const ListaNotificacoes({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: messages.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) => messages[index],
      ),
    );
  }
}
