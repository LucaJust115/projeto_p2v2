import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Abastecimento extends StatefulWidget {
  final String veiculoId; // O ID do veículo é passado para registrar o abastecimento para um veículo específico
  Abastecimento({required this.veiculoId});

  @override
  _AbastecimentoState createState() => _AbastecimentoState();
}

class _AbastecimentoState extends State<Abastecimento> {
  final _quantidadeController = TextEditingController();
  final _precoController = TextEditingController();
  final _totalGastoController = TextEditingController(); // Campo de total gasto
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Função para calcular o total gasto
  void _calcularTotal() {
    double quantidade = double.tryParse(_quantidadeController.text) ?? 0;
    double preco = double.tryParse(_precoController.text) ?? 0;
    double total = quantidade * preco;

    // Atualiza o campo totalGastoController com o valor calculado
    _totalGastoController.text = total.toStringAsFixed(2);
  }

  // Função para registrar o abastecimento
  Future<void> _registrarAbastecimento() async {
    // Adiciona o novo abastecimento ao Firebase
    await _firestore.collection('abastecimentos').add({
      'veiculoId': widget.veiculoId, // ID do veículo
      'quantidade': _quantidadeController.text, // Quantidade de litros
      'preco': _precoController.text, // Preço por litro
      'total': _totalGastoController.text, // Total gasto
      'data': DateTime.now(), // Data do abastecimento
    });

    Navigator.pop(context);  // Volta para a tela anterior após o registro
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Abastecimento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Campo para inserir a quantidade de litros
            TextField(
              controller: _quantidadeController,
              decoration: InputDecoration(labelText: 'Quantidade (L)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) => _calcularTotal(), // Chama o cálculo do total ao alterar o valor
            ),
            // Campo para inserir o preço por litro
            TextField(
              controller: _precoController,
              decoration: InputDecoration(labelText: 'Preço por Litro (R\$)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) => _calcularTotal(), // Chama o cálculo do total ao alterar o valor
            ),
            // Campo para exibir o total gasto (calculado automaticamente)
            TextField(
              controller: _totalGastoController,
              decoration: InputDecoration(labelText: 'Total Gasto (R\$)'),
              readOnly: true,  // O campo é somente leitura, pois o valor é calculado
            ),
            SizedBox(height: 20),
            // Botão para registrar o abastecimento
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
