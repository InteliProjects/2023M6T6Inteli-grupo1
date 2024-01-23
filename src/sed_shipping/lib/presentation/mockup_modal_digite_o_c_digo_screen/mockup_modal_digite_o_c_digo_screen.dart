import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MockupModalDigiteOCDigoScreen extends StatelessWidget {
  MockupModalDigiteOCDigoScreen({Key? key}) : super(key: key);

  TextEditingController dataInicialController = TextEditingController();
  TextEditingController dataFinalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 9),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "S",
                          style: TextStyle(color: Colors.indigo),
                        ),
                        TextSpan(
                          text: "E",
                          style: TextStyle(color: Colors.amber),
                        ),
                        TextSpan(
                          text: "D",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 11),
              Divider(),
              Spacer(flex: 39),
              Padding(
                padding: EdgeInsets.only(left: 18),
                child: Text(
                  "Alterar data prevista*",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _dataPrevista(context, dataInicialController,
                  "Data inicial prevista de entrega"),
              SizedBox(height: 20),
              _dataPrevista(context, dataFinalController,
                  "Data final prevista de entrega"),
              Spacer(flex: 7),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    onTapSalvar(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 8, 90, 158),
                  ),
                  child: Text(
                    "Salvar",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Spacer(flex: 34),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dataPrevista(
      BuildContext context, TextEditingController controller, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 3),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  _selectDate(context, controller);
                },
                child: AbsorbPointer(
                  absorbing: true,
                  child: Container(
                    color: Colors.grey[300],
                    child: TextFormField(
                      controller: controller,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintText: hintText,
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: hintText == "Alterar data prevista"
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      controller.text = formattedDate;
    }
  }

  void onTapSalvar(BuildContext context) {
    Navigator.pop(context);
  }
}
