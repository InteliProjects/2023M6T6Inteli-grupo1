import 'package:flutter/material.dart';
import '../home/components/sedName.dart';
import '../menu/menu.dart';
class editar_entrega extends StatelessWidget {
  // Adicione uma variável para rastrear a seleção do item

  String? dropdownItemValue;
  String? dropdownDiretoriaValue;
  int? quantidade = 0;
  String? dropdownFornecedorValue;
  String cie = "";
  int? entrega = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: Text('Cadastro de Entrega'),
        centerTitle: true,
        actions: <Widget>[
          Menu(), // Add the menu component here as an action
        ],
      ),
        body: SingleChildScrollView( // Use SingleChildScrollView to enable scrolling
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Center(child: sedName()), // Custom centered widget
              ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Substitua o TextField pelo DropdownButtonFormField
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Item',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 21, 91, 203),
                          width: 2.0,
                        ),
                      ),
                    ),
                    value: dropdownItemValue,
                    onChanged: (String? newValue) {
                      // Atualize a seleção do item
                      dropdownItemValue = newValue;
                    },
                    items: const <String>[
                      'Material Educativo Esportivo e Culturalo',
                      'Outros Materiais de Consumo',
                      'Lousa verde quadriculada',
                      'Mobiliário em Geral',
                      'Dispositivo Eletrolítico',
                      'Equipamentos para Informática',
                      'Kit Escolar',
                      'Material Esportivo',
                      'Televisor',
                      'Estante Simples',
                      'Ventilador de parede',
                      'Quadro'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 23),

                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Diretoria',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 21, 91, 203),
                          width: 2.0,
                        ),
                      ),
                    ),
                    value: dropdownItemValue,
                    onChanged: (String? newValue) {
                      // Atualize a seleção do item
                      dropdownDiretoriaValue = newValue;
                    },
                    items: const <String>[
                      'Norte 1',
                      'Norte 2',
                      'Centro',
                      'Centro Oeste',
                      'Centro Sul',
                      'Sul 1',
                      'Sul 2',
                      'Sul 3',
                      'Leste 1',
                      'Leste 2',
                      'Leste 3',
                      'Leste 4',
                      'Leste 5'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 23),
                  TextField(
                    onChanged: (value) {
                      int? novaQuantidade = int.tryParse(value);
                      if (novaQuantidade != null){
                          quantidade = novaQuantidade;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Quantidade',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 21, 91, 203),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 21, 91, 203),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 23),

                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Fornecedor',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 21, 91, 203),
                          width: 2.0,
                        ),
                      ),
                    ),
                    value: dropdownItemValue,
                    onChanged: (String? newValue) {
                      // Atualize a seleção do item
                      dropdownFornecedorValue = newValue;
                    },
                    items: const <String>[
                      'XP On Consultoria LTDA',
                      'Wellington Scarparo Botaro Me',
                      'Weblabor São Paulo Materiais Didáticos',
                      'W3 Industria Metalurgica LTDA',
                      'Ventisol Industria e Comércio'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 23),
                  TextField(
                    onChanged: (value) {
                      cie = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'CIE da escola',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 21, 91, 203),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 21, 91, 203),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  // Repita o padrão para outros campos de texto...

                  SizedBox(height: 23),
                  TextField(
                    onChanged: (value) {
                      int? novaQuantidade = int.tryParse(value);
                      if (novaQuantidade != null){
                          entrega = novaQuantidade;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Dias Até a Entrega',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 21, 91, 203),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 21, 91, 203),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  // Repita o padrão para outros campos de texto...

                  SizedBox(
                      height: 23), // Espaço entre os campos de texto e o botão

                  // Botão Personalizado
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 21, 91, 203),
                      onPrimary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                            Navigator.of(context).pushReplacementNamed("/home");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Compra editada com sucesso!'),
                                duration: Duration(seconds: 3),
                              ),
                            );

                          }
                    ,
                    child: Text('Editar Entrega',
                        style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ]))));
  }
}
