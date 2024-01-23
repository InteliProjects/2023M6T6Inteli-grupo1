import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sed_supplier/services/cadastrar_service.dart';

class Cadastro extends StatelessWidget {
  String email = "";
  String senha = "";
  String razaoSocial = "";
  String cnpj = "";
  String confirmarSenha = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  // Texto 'SED' com cores diferentes
                  text: TextSpan(
                    style: TextStyle(fontSize: 60.0),
                    children: [
                      TextSpan(
                        text: 'S',
                        style:
                            TextStyle(color: Color.fromRGBO(38, 112, 232, 1)),
                      ),
                      TextSpan(
                        text: 'E',
                        style:
                            TextStyle(color: Color.fromRGBO(37, 211, 102, 1)),
                      ),
                      TextSpan(
                        text: 'D',
                        style:
                            TextStyle(color: Color.fromRGBO(242, 227, 23, 1)),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.0),

                // Campo de Email
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    onChanged: (text) {
                      email = text;
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Campo de Razão Social
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    onChanged: (text) {
                      razaoSocial = text;
                    },
                    decoration: InputDecoration(
                      hintText: 'Razão Social',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Campo de CNPJ
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    onChanged: (text) {
                      cnpj = text;
                    },
                    decoration: InputDecoration(
                      hintText: 'CNPJ',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Campo de Senha
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    onChanged: (text) {
                      senha = text;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Campo de Confirmar Senha
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    onChanged: (text) {
                      confirmarSenha = text;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirmar Senha',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40),

                ElevatedButton(
                  onPressed: () {
                    if (senha == confirmarSenha) {
                      createUser(email, senha, razaoSocial).then((response) {
                      if (response.statusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Usuario criado!"),));
                    Navigator.of(context).pushReplacementNamed("/login");
                  }else {
                    if(response.statusCode == 500){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Email já cadastrado!"),));
                  }
                  }});
                    }else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Senhas diferentes!"),
                    ));
                  }
                  },
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(19, 81, 180, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
