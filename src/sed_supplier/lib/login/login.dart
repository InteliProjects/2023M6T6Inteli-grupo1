import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sed_supplier/services/login_service.dart';

class LoginScreen extends StatelessWidget {
  String email = "";
  String senha = "";

  @override
  Widget build(BuildContext context) {
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
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'S',
                    style: TextStyle(
                        color: Color.fromRGBO(38, 112, 232, 1),
                        fontSize: 80,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'E',
                    style: TextStyle(
                        color: Color.fromRGBO(242, 217, 23, 1),
                        fontSize: 80,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'D',
                    style: TextStyle(
                        color: Color.fromRGBO(37, 211, 102, 1),
                        fontSize: 80,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (text) {
                email = text;
              },
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (text) {
                senha = text;
              },
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                getLogin(email, senha).then((response) {
                  if (response.statusCode == 200) {
                    var json = jsonDecode(response.body);
                    saveData("tokenSupplierUsers", json['token']);

                    Navigator.of(context)
                        .pushReplacementNamed("/home");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Email ou senha incorretos!"),
                    ));
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromRGBO(19, 81, 180, 1), // Cor de fundo do botão
              ),
              child: Text(
                'Acessar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 70),
            TextButton(
              onPressed: () { 
                Navigator.of(context).pushReplacementNamed("/cadastro");
              },
              child: Text(
                'Criar Conta',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
