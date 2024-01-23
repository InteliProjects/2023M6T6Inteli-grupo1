import 'package:flutter/material.dart';
import '/components/escolas.dart';
import '/components/titulo_diretoria.dart';

class lista_escolas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Escolas'),
      ),
      body: SingleChildScrollView(
        // Certifique-se de que a lista é rolável se for muito longa
        child: Column(
          children: [
            titulo_diretoria(diretoria: 'Sul'),
            Escolas(
              nome_escola: 'Instituto de Tecnologia e Liderança',
              regiao: 'São Paulo/Metropolitana',
              endereco:
                  'Av. Prof. Almeida Prado, 520 - Butantã, São Paulo - SP, 05508-070',
              situacao_entrega: 'Em trânsito',
              previsaoEntrega: '22/10/2023',
              quantidade_recebida: 7000,
            ),
            Escolas(
              nome_escola: 'Instituto de Tecnologia e Liderança',
              regiao: 'São Paulo/Metropolitana',
              endereco:
                  'Av. Prof. Almeida Prado, 520 - Butantã, São Paulo - SP, 05508-070',
              situacao_entrega: 'Em trânsito',
              previsaoEntrega: '22/10/2023',
              quantidade_recebida: 7000,
            ),
            titulo_diretoria(diretoria: 'Norte'), // Novo título de diretoria
            Escolas(
              nome_escola: 'Instituto de Tecnologia e Liderança',
              regiao: 'São Paulo/Metropolitana',
              endereco:
                  'Av. Prof. Almeida Prado, 520 - Butantã, São Paulo - SP, 05508-070',
              situacao_entrega: 'Em trânsito',
              previsaoEntrega: '22/10/2023',
              quantidade_recebida: 7000,
            ),
            Escolas(
              nome_escola: 'Instituto de Tecnologia e Liderança',
              regiao: 'São Paulo/Metropolitana',
              endereco:
                  'Av. Prof. Almeida Prado, 520 - Butantã, São Paulo - SP, 05508-070',
              situacao_entrega: 'Em trânsito',
              previsaoEntrega: '22/10/2023',
              quantidade_recebida: 7000,
            ),
            // Adicione mais widgets Escolas conforme necessário
          ],
        ),
      ),
    );
  }
}
