import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sed_school/componentes_globais/tituloSed.dart';
import 'package:sed_school/home/home.dart';
import 'package:sed_school/services/entrega_service.dart';


class ReviewScreen extends StatefulWidget {
  final String id; // Adicione esta linha

  ReviewScreen({Key? key, required this.id}) : super(key: key); // Modifique esta linha

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}


class _ReviewScreenState extends State<ReviewScreen> {
    double nota = 0; // Variável para armazenar o rating


  @override
  Widget build(BuildContext context) {
    String id = widget.id;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: const TituloSed(),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Avaliar a entrega',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                   setState(() {
                  nota = rating; // Atualiza o estado com o novo rating
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child:ElevatedButton(
                    onPressed: () {
                      // Mostra um AlertDialog para confirmação
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmar Avaliação'),
                            content: Text('Deseja mesmo avaliar essa entrega com a nota $nota ?'),
                            actions: <Widget>[
                              // Botão para cancelar
                              TextButton(
                                child: Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Fecha o diálogo
                                },
                              ),
                              // Botão para confirmar
                              TextButton(
                                child: Text('Confirmar'),
                                      onPressed: () {
                                        // Coloque aqui a lógica para avaliar a entrega
                                        
                                        pedidoRecebidoStatus(nota, id).then((value) {
                                            Navigator.of(context).pop(); // Fecha o diálogo
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => HomeScreen(),
                                                ),
                                            );
                                        });
                                    },
                              ),
                            ],
                          );
                        },
                    );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10), // Ajuste de padding
                      backgroundColor: Color.fromRGBO(19, 81, 180, 1), // Cor de fundo do botão
                    ),
                    child: Text(
                      'Avaliar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16, // Ajuste de tamanho de texto
                      ),
                    ),
                  )
            ),
          ],
        ),
      ),
    );
  }
}
