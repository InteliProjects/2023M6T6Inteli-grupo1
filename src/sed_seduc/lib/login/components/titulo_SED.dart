import 'package:flutter/material.dart';



//aqui vamos componetiar o TITULO SED para agilidade do codigo

class titulo_SED extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    return const Padding(
    padding: EdgeInsets.only(top: 60.0), // Ajuste o espaçamento conforme necessário
    child: Text(
      'SED',
      style: TextStyle(
        fontSize: 40, // Tamanho do texto
        fontWeight: FontWeight.bold,
        color: Colors.blue, // Cor do texto "SED"
      ),
      
    ),
  );
}
}