import 'package:flutter/material.dart';
import '/components/sedName.dart';

class EditarEntrega extends StatelessWidget {
  String? dropdownItemValue;
  String? dropdownDiretoriaValue;
  int? quantidade = 0;
  String? dropdownFornecedorValue;
  String cie = "";
  String prazo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
                      if (novaQuantidade != null) {
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
                      labelText: 'Nome da transportadora',
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
                      'Rodonaves',
                      'Jadlog',
                      'UPS',
                      'Braspress',
                      'Correios',
                      'Outra'
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
                    decoration: InputDecoration(
                      labelText: 'Numero da nota fiscal',
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

                  TextField(
                    onChanged: (value) {
                      prazo = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Status',
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
                      print('Botão Pressionado');
                    },
                    child:
                        Text('Editar Entrega', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
