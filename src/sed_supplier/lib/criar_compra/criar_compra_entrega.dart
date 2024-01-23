import 'package:flutter/material.dart';
import 'package:sed_supplier/components/menu_dropdown.dart';
import 'package:sed_supplier/services/diretoria_service.dart';
import 'package:sed_supplier/services/entrega_service.dart';
import 'package:sed_supplier/services/shipping_service.dart';
import '/components/sedName.dart';
import 'package:intl/intl.dart';


class Shipping{
  final int id;
  final String name;

  Shipping({required this.id, 
  required this.name});
}

class Escolas{
  final int id;
  final String name;

  Escolas({required this.id, 
  required this.name});
}


class Diretoria {
  final int id;
  final String name;
  final List<Escolas> escolas;

  Diretoria({required this.id, 
  required this.name,
  required this.escolas});
}


class CadastroCompra extends StatefulWidget {
  final String itemNome;
  final int orderId;

  CadastroCompra({required this.orderId, required this.itemNome, Key? key}) : super(key: key);

  @override
  _CadastroCompraState createState() => _CadastroCompraState();
}

class _CadastroCompraState extends State<CadastroCompra> {
  List<Escolas> escolasDaDiretoriaSelecionada = [];
  String? dropdownEscolaValue;
  String? dropdownItemValue;
  String? dropdownDiretoriaValue;
  int? quantidade = 0;
  String? dropdownFornecedorValue;
  String cie = "";
  String dataAtual = "";
  String dataEntrega = "";
  int prazo = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar:  AppBar(
        actions: const [
           MenuHamburguer()
        ],
        title: const Text(''), // Deixe o title vazio
      ),
        body: SingleChildScrollView( 
        child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .center, // Alinha os filhos horizontalmente ao centro
            children: [
          const Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: sedName(), // O seu widget customizado centralizado
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Criar pedido de entrega para:  ${widget.itemNome}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),

                  const SizedBox(height: 23),
        
                  FutureBuilder<List<dynamic>>(
                    future: getListDiretorias(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                          var jsonData = snapshot.data as List;
                          List<Diretoria> diretorias = [];
                          for (var item in jsonData) {
                            List<Escolas> escolas = [];
                            for (var escola in item['schools']) {
                              escolas.add(Escolas(id: escola['id'], name: escola['name']));
                            }
                            diretorias.add(Diretoria(id: item['id'], name: item['name'],escolas: escolas));
                          }

                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                                labelText: 'Nome da Diretoria',
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide:const  BorderSide(
                                    color: Color.fromARGB(255, 21, 91, 203),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                          value: dropdownDiretoriaValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownDiretoriaValue = newValue;
                              var diretoriaSelecionada = diretorias.firstWhere((diretoria) => diretoria.id.toString() == newValue);
                              escolasDaDiretoriaSelecionada = diretoriaSelecionada.escolas;
                            });
                          },
                          items: diretorias.map<DropdownMenuItem<String>>((Diretoria diretoria) {
                            return DropdownMenuItem<String>(
                              value: diretoria.id.toString(),
                              child: Text(diretoria.name),
                            );
                          }).toList(),
                        );
                      } else {
                        return  const CircularProgressIndicator();
                      }
                    },
                  ),
                  const SizedBox(height: 23),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Nome da Escola',
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:const  BorderSide(
                          color: Color.fromARGB(255, 21, 91, 203),
                          width: 2.0,
                        ),
                      ),
                    ),
                    value: dropdownEscolaValue,
                    onChanged: (String? newValue) {
                      // Atualize a seleção do item
                      dropdownEscolaValue = newValue;
                    },
                      items: escolasDaDiretoriaSelecionada.map<DropdownMenuItem<String>>((Escolas escola) {
                      return DropdownMenuItem<String>(
                        value: escola.id.toString(),
                        child: Text(escola.name),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 23),
                  TextField(
                    onChanged: (value) {
                      int? novaQuantidade = int.tryParse(value);
                      if (novaQuantidade != null) {
                        quantidade = novaQuantidade;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Quantidade',
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 21, 91, 203),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 21, 91, 203),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 23),

                  FutureBuilder<List<dynamic>>(
                    future: getListShipping(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                          var jsonData = snapshot.data as List;
                          List<Shipping> shippings = [];
                          for (var item in jsonData) {
                            shippings.add(Shipping(id: item['id'], name: item['name']));
                          }

                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                                labelText: 'Nome da Transportadora',
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide:const  BorderSide(
                                    color: Color.fromARGB(255, 21, 91, 203),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                          value: dropdownFornecedorValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownFornecedorValue = newValue;
                            });
                          },
                          items: shippings.map<DropdownMenuItem<String>>((Shipping shipping) {
                            return DropdownMenuItem<String>(
                              value: shipping.id.toString(),
                              child: Text(shipping.name),
                            );
                          }).toList(),
                        );
                      } else {
                        return  const CircularProgressIndicator();
                      }
                    },
                  ),
                  const SizedBox(height: 23), 

                  TextField(
                    onChanged: (value) {
                      prazo = int.parse(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Prazo',
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 21, 91, 203),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 21, 91, 203),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  // Repita o padrão para outros campos de texto...

                  const SizedBox(height: 23),

                  // Botão Personalizado
                  ElevatedButton(
                    style:  ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 21, 91, 203),
                      onPrimary: Colors.white,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      var now =  DateTime.now();
                      var formatter =  DateFormat('dd-MM-yyyy');
                      String formattedDate = formatter.format(now);
                      dataAtual = formattedDate;

                      var dataFutura = now.add(Duration(days: prazo));
                      dataEntrega = formatter.format(dataFutura);

                      createDelivery(widget.orderId, int.parse(dropdownEscolaValue!), int.parse(dropdownFornecedorValue!), quantidade!, dataAtual, dataEntrega).then((response) {
                      if (response.statusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Entrega Criada!"),));
                    Navigator.of(context).pushReplacementNamed("/home");
                  }else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Algo deu errado!"),));
                  }
                  });
                    },
                    child: const Text('Registrar Entrega',
                        style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ])));
  }
}
