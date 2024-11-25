import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Abastecimento extends StatefulWidget {
  final String veiculoId;
  Abastecimento({required this.veiculoId});

  @override
  _AbastecimentoState createState() => _AbastecimentoState();
}

class _AbastecimentoState extends State<Abastecimento> {
  final _quantidadeController = TextEditingController();
  final _precoController = TextEditingController();
  final _totalGastoController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _registrarAbastecimento() async {
    await _firestore.collection('abastecimentos').add({
      'veiculoId': widget.veiculoId,
      'quantidade': _quantidadeController.text,
      'preco': _precoController.text,
      'total': _totalGastoController.text,
      'data': DateTime.now(),
    });

    Navigator.pop(context);  // Volta após o registro
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Abastecimento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _quantidadeController,
              decoration: InputDecoration(labelText: 'Quantidade (L)'),
            ),
            TextField(
              controller: _precoController,
              decoration: InputDecoration(labelText: 'Preço por Litro (R\$)'),
            ),
            TextField(
              controller: _totalGastoController,
              decoration: InputDecoration(labelText: 'Total Gasto (R\$)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registrarAbastecimento,
              child: Text('Registrar Abastecimento'),
            ),
          ],
        ),
      ),
    );
  }
}
