import 'package:flutter/material.dart';
import '../home/components/sedName.dart';
import '../menu/menu.dart';
import '../serviço/api_service.dart';

class CadastroEntregaScreen extends StatefulWidget {
  @override
  _CadastroEntregaScreenState createState() => _CadastroEntregaScreenState();
}

class _CadastroEntregaScreenState extends State<CadastroEntregaScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? dropdownItemValue;
  Map<String, dynamic>? dropdownDiretoriaValue;
  int? quantidade = 0;
  String? categoria = "";
  Map<String, dynamic>? dropdownFornecedorValue;
  String cie = "";
  int? entrega = 0;

  late List<Map<String, dynamic>> items = [];
  late List<Map<String, dynamic>> schoolBoards = [];
  late List<Map<String, dynamic>> suppliers = [];

  final ApiService apiService = ApiService(baseUrl: 'http://34.224.239.245');

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      items = await apiService.fetchItems();
      schoolBoards = await apiService.fetchSchoolsBords();
      suppliers = await apiService.fetchSuppliers();
      setState(() {
        items;
        schoolBoards;
        suppliers;
      });
    } catch (e) {
      print('Error loading items: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
    Navigator.of(context).pushReplacementNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Cadastro de Entrega'),
        centerTitle: true,
        actions: <Widget>[
          Menu(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 60.0, child: sedName()),
            SizedBox(height: 25),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  DropdownButtonFormField<String>(
                    isExpanded: true,
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
                      setState(() {
                        dropdownItemValue = newValue;
                      });
                    },
                    items: items.map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item['itemName'],
                        child: Text(item['itemName']),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: (value) {
                      String? novacategoria = value;
                      categoria = novacategoria;
                    },
                    decoration: InputDecoration(
                      labelText: 'Categoria',
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
                  SizedBox(height: 16),
                  DropdownButtonFormField<Map<String, dynamic>>(
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
                    value: dropdownDiretoriaValue,
                    onChanged: (Map<String, dynamic>? newValue) {
                      setState(() {
                        dropdownDiretoriaValue = newValue;
                      });
                    },
                    items: schoolBoards
                        .map<DropdownMenuItem<Map<String, dynamic>>>((board) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: board,
                        child: Text(board['name']),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
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
                  SizedBox(height: 16),
                  DropdownButtonFormField<Map<String, dynamic>>(
                    isExpanded: true,
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
                    value: dropdownFornecedorValue,
                    onChanged: (Map<String, dynamic>? newValue) {
                      setState(() {
                        dropdownFornecedorValue = newValue;
                      });
                    },
                    items: suppliers
                        .map<DropdownMenuItem<Map<String, dynamic>>>(
                            (supplier) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: supplier,
                        child: Text(supplier['name']),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
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
                  SizedBox(height: 16),
                  TextField(
                    onChanged: (value) {
                      int? novaQuantidade = int.tryParse(value);
                      if (novaQuantidade != null) {
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
                  SizedBox(height: 16),
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                "Tem certeza que deseja registrar o pedido?"),
                            content: Text(
                                "Após a confirmação, a ação não poderá ser revertida."),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Cancelar"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Confirmar"),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  try {
                                    Map<String, dynamic> postData = {
                                      'itemName': dropdownItemValue,
                                      'schoolBoard':
                                          dropdownDiretoriaValue?["id"],
                                      'quantity': quantidade,
                                      'supplierId':
                                          dropdownFornecedorValue?["id"],
                                      'cie': cie,
                                      'entrega': entrega,
                                      'category': categoria,
                                    };

                                    await apiService.createOrder(postData);

                                    _showSnackBar(
                                        'Pedido registrado com sucesso!');
                                  } catch (e) {
                                    print('Erro ao registrar o pedido: $e');
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Registrar Entrega',
                        style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
