import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:renan_s_application8/core/app_export.dart';
import 'package:renan_s_application8/presentation/mockup_modal_digite_o_c_digo_one_screen/mockup_modal_digite_o_c_digo_one_screen.dart';
import 'dart:convert';
import 'package:renan_s_application8/widgets/custom_elevated_button.dart';

class MockupEntregaScreen extends StatefulWidget {
  final String? parsedID;

  const MockupEntregaScreen({Key? key, this.parsedID}) : super(key: key);

  @override
  _MockupEntregaScreenState createState() => _MockupEntregaScreenState();
}

class _MockupEntregaScreenState extends State<MockupEntregaScreen> {
  late Future<Map<String, dynamic>> deliveryDetailsFuture;
  Map<String, dynamic>? deliveryDetails;

  @override
  void initState() {
    super.initState();
    deliveryDetailsFuture = fetchDeliveryDetails();
  }

  Future<Map<String, dynamic>> fetchDeliveryDetails() async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://34.224.239.245/shippingCompanies/deliveries/${widget.parsedID}',
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          deliveryDetails = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
    return {
      'orderId': 123,
      'order': {'category': 'Categoria'}
    };
  }

  Widget _buildStatusInfo(Map<String, dynamic> deliveryData,
      Map<String, dynamic> statusChange, int index) {
    bool showCreatedBy = index == 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showCreatedBy)
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Entrega #${deliveryData['orderId']}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Criada por ${deliveryData['order']['supplier']['name']}",
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[100],
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Status: ${getStatusText(deliveryData, statusChange)}",
                  style: getStatusTextStyle(statusChange),
                ),
                SizedBox(height: 8),
                Text(
                  "Data: ${getDateText(statusChange['moment'])}",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDeliveryDetails(Map<String, dynamic> deliveryData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 11),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "S",
                style: CustomTextStyles.displaySmallBlueA400,
              ),
              TextSpan(
                text: "E",
                style: CustomTextStyles.displaySmallYellowA400,
              ),
              TextSpan(
                text: "D",
                style: CustomTextStyles.displaySmallGreenA700,
              )
            ]),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 9),
        Center(
          child: Text(
            "Notificações",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 9),
        SizedBox(height: 16),
        for (var i = 0; i < deliveryData['statusChanges'].length; i++)
          _buildStatusInfo(deliveryData, deliveryData['statusChanges'][i], i),
      ],
    );
  }

  String getStatusText(
      Map<String, dynamic> deliveryData, Map<String, dynamic> statusChange) {
    String status = statusChange['next_status_id'];

    switch (status) {
      case 'CREATED':
        return 'Entrega criada';
      case 'SEPARATED':
        return 'Entrega separada';
      case 'DELIVERY':
        return 'Entrega em andamento';
      case 'COMPLETED':
        return 'Entrega concluída';
      case 'CANCELED':
        return 'Entrega cancelada';
      default:
        return 'Status desconhecido';
    }
  }

  TextStyle getStatusTextStyle(Map<String, dynamic> statusChange) {
    String status = statusChange['next_status_id'];

    switch (status) {
      case 'CREATED':
        return TextStyle(color: Colors.blue);
      case 'SEPARATED':
        return TextStyle(color: Colors.orange);
      case 'DELIVERY':
        return TextStyle(color: Colors.purple);
      case 'COMPLETED':
        return TextStyle(color: Colors.green);
      case 'CANCELED':
        return TextStyle(color: Colors.red);
      default:
        return TextStyle(color: Colors.black);
    }
  }

  String getDateText(String moment) {
    final parsedDate = DateTime.parse(moment);
    return DateFormat('dd/MM/yyyy HH:mm').format(parsedDate);
  }

  Widget _buildOrderConfirmation(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.maxFinite,
      child: Stack(alignment: Alignment.center, children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: 8.v, right: 135.h),
            child: Text("Label", style: theme.textTheme.titleMedium),
          ),
        ),
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 28.h, vertical: 11.v),
          decoration: AppDecoration.fillBlueGray,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomElevatedButton(
                width: 167.h,
                text: "Confirmar Entrega",
                margin: EdgeInsets.only(top: 3.v),
                onPressed: () {
                  onTapConfirmarEntrega(context);
                },
              ),
              Container(
                child: CustomImageView(
                  imagePath: ImageConstant.imgEdit,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  margin: EdgeInsets.only(left: 45.h, top: 8.v, bottom: 7.v),
                  onTap: () {
                    onTapImgEdit(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void onTapConfirmarEntrega(BuildContext context) {
    if (widget.parsedID != null) {
      print(widget.parsedID);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MockupModalDigiteOCDigoOneScreen(parsedID: widget.parsedID),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text(
                'Por favor, insira um número válido para o ID da entrega.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void onTapImgEdit(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.mockupModalDigiteOCDigoScreen);
  }

  Widget _buildMainContent(Map<String, dynamic> deliveryDetails) {
    return Column(
      children: [
        _buildDeliveryDetails(deliveryDetails),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
          future: deliveryDetailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16.0),
                    Text('Carregando...'),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar os dados.'));
            } else if (snapshot.hasData) {
              if (deliveryDetails == null) {
                deliveryDetails = snapshot.data;
              }
              return SingleChildScrollView(
                child: _buildMainContent(deliveryDetails!),
              );
            } else {
              return Center(child: Text('Nenhum dado disponível.'));
            }
          },
        ),
        bottomNavigationBar:
            deliveryDetails != null ? _buildOrderConfirmation(context) : null,
      ),
    );
  }
}
