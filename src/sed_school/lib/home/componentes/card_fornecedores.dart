import 'package:flutter/material.dart';
import 'package:sed_school/entrega/entrega.dart';




class CardFornecedor extends StatelessWidget {
  const CardFornecedor({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.finalForecast,
    required this.numero_entrega,
    required this.status_entrega,
    required this.nome_escola,
    required this.nome_item,
    required this.id,



  }) : super(key: key);

  


  final String title;
  final String subtitle;
  final String trailing;
  final String numero_entrega;
  final String status_entrega;
  final String nome_escola;
  final String nome_item;
  final String id;
  final String finalForecast;
 

 

  @override
  Widget build(BuildContext context) {
   
    Widget statusWidget = SizedBox.shrink();
    String status = status_entrega;

     if (status=='COMPLETED'){
        status = 'ENTREGE';
        statusWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(status),
          ],
        );
     }else if (status=='SEPARATED'){
              status = 'SEPARADO PARA ENTREGA';
        statusWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(status),
            Text('$trailing - $finalForecast'),
          ],
        );
     }else if (status=='DELIVERY'){
              status = 'SAIU PARA ENTREGA';
        statusWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(status),
            Text('$trailing - $finalForecast'),
          ],
        );
     }else if (status=='CREATED'){
              status = 'CRIADO';
        statusWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(status),
            Text('$trailing - $finalForecast'),
          ],
        );
     }
   
    // Verifica se statusWidget foi definido, caso contrário, usa o statusText
    statusWidget ??= Text(status);
    
    return Card(
      color:Colors.white,
      child: ListTile(
        title: Text(title),
        subtitle: Text('$subtitle $nome_item'),
        trailing: statusWidget,
        onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(numero_entrega: numero_entrega, status_entrega: status_entrega, nome_escola: nome_escola, nome_item: nome_item, quantidade: subtitle,id:id),
                    ),
                  );
                },
      ),
      elevation: 2,
    );
  }
}
