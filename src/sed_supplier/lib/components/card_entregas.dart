import 'package:flutter/material.dart';

class card_entrega extends StatelessWidget {
  final String itemName;
  final int quantity;
  final String supplierName;
  final bool isChecked;
  final String schoolName;
  final void Function(bool)? onCheckboxChanged; // Corrigido o tipo de retorno

  card_entrega({
    required this.itemName,
    required this.quantity,
    required this.supplierName,
    required this.schoolName,
    this.isChecked = false,
    this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 21, 91, 203),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: onCheckboxChanged as void Function(
                bool?)?, // Corrigido o tipo de retorno
            fillColor: MaterialStateProperty.all(Colors.white),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Quantidade: $quantity',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Spacer(), // Adiciona espaço flexível entre as colunas
          Text(
            'Fornecedor: $supplierName',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(), // Adiciona espaço flexível entre as colunas
          Text(
            'Escola: $schoolName',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          
        ],
      ),
    );
  }
}
