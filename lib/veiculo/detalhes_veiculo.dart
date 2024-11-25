import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_p2v2/abastecimento/tela_abastecimento.dart';

import '../abastecimento/historico_abastecimentos.dart';

class DetalhesVeiculo extends StatefulWidget {
  final String veiculoId;
  DetalhesVeiculo({required this.veiculoId});

  @override
  _DetalhesVeiculoState createState() => _DetalhesVeiculoState();
}

class _DetalhesVeiculoState extends State<DetalhesVeiculo> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late DocumentSnapshot veiculo;

  Future<void> _carregarDetalhes() async {
    veiculo = await _firestore.collection('veiculos').doc(widget.veiculoId).get();
    setState(() {});  // Atualiza a tela quando os dados forem carregados
  }

  Future<void> _deletarVeiculo() async {
    await _firestore.collection('veiculos').doc(widget.veiculoId).delete();
    Navigator.pop(context);  // Volta para a tela anterior após excluir
  }

  @override
  void initState() {
    super.initState();
    _carregarDetalhes();
  }

  @override
  Widget build(BuildContext context) {
    if (veiculo == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Detalhes do Veículo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Nome: ${veiculo['nome']}'),
            Text('Modelo: ${veiculo['modelo']}'),
            Text('Ano: ${veiculo['ano']}'),
            Text('Placa: ${veiculo['placa']}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _deletarVeiculo,
              child: Text('Excluir Veículo'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela de abastecimento
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Abastecimento(veiculoId: widget.veiculoId),
                  ),
                );
              },
              child: Text('Registrar Abastecimento'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Visualizar histórico de abastecimentos
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoricoAbastecimentos(veiculoId: widget.veiculoId),
                  ),
                );
              },
              child: Text('Ver Histórico de Abastecimentos'),
            ),
          ],
        ),
      ),
    );
  }
}
