import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:renan_s_application8/core/app_export.dart';
import 'package:renan_s_application8/presentation/mockup_entrega_screen/mockup_entrega_screen.dart';
import 'package:renan_s_application8/widgets/custom_elevated_button.dart';
import 'package:renan_s_application8/widgets/custom_pin_code_text_field.dart';
import 'package:http/http.dart' as http;

class MockupModalDigiteOCDigoOneScreen extends StatefulWidget {
  final String? parsedID;

  const MockupModalDigiteOCDigoOneScreen({Key? key, this.parsedID})
      : super(key: key);

  @override
  _MockupModalDigiteOCDigoOneScreenState createState() =>
      _MockupModalDigiteOCDigoOneScreenState();
}

class _MockupModalDigiteOCDigoOneScreenState
    extends State<MockupModalDigiteOCDigoOneScreen> {
  String? codigo;
  bool codigoCorreto = false;
  TextEditingController receiptCodeController = TextEditingController();

  void showStatusUpdateModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Status Atualizado"),
          content: Text("O status da entrega foi atualizado com sucesso."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MockupEntregaScreen(parsedID: widget.parsedID),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 11 * mediaQueryData.size.width / 375),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 17 * mediaQueryData.size.width / 375),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "S",
                              style: CustomTextStyles.displaySmallIndigoA400),
                          TextSpan(
                              text: "E",
                              style: CustomTextStyles.displaySmallAmber300),
                          TextSpan(
                              text: "D",
                              style: CustomTextStyles.displaySmallGreen500)
                        ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 11 * mediaQueryData.size.height / 812),
                  Divider(),
                  SizedBox(height: 39 * mediaQueryData.size.height / 812),
                  Text(
                    "Digite o código de entrega",
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: 40 * mediaQueryData.size.height / 812),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 56 * mediaQueryData.size.width / 375),
                    child: CustomPinCodeTextField(
                      controller: receiptCodeController,
                      context: context,
                      onChanged: (value) {
                        setState(() {
                          codigo = value;
                          codigoCorreto = false;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 25 * mediaQueryData.size.height / 812),
                  CustomElevatedButton(
                      width: 167 * mediaQueryData.size.width / 375,
                      height: 50 * mediaQueryData.size.height / 812,
                      text: "Confirmar Entrega",
                      onPressed: () {
                        fetchDeliveryDetails();
                      }),
                  SizedBox(height: 34 * mediaQueryData.size.height / 812),
                  if (codigoCorreto)
                    Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 50,
                    ),
                ],
              ),
            ),
          )),
    );
  }

  fetchDeliveryDetails() async {
    try {
      final Map<String, dynamic> requestBody = {
        "status": "COMPLETED",
        "receiptCode": receiptCodeController.text
      };

      final response = await http.patch(
        Uri.parse(
          'http://34.224.239.245/shippingCompanies/deliveries/${widget.parsedID}',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        showStatusUpdateModal();
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
    await Future.delayed(Duration(seconds: 2));
  }
}
