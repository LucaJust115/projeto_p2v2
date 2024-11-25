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

  Future<DocumentSnapshot> _carregarDetalhes() async {
    return await _firestore.collection('veiculos').doc(widget.veiculoId).get();
  }

  Future<void> _deletarVeiculo() async {
    await _firestore.collection('veiculos').doc(widget.veiculoId).delete();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Veículo'),
        backgroundColor: Colors.blueAccent, // Cor de fundo da AppBar
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _carregarDetalhes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar veículo'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Veículo não encontrado.'));
          }

          var veiculo = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Nome: ${veiculo['nome']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('Modelo: ${veiculo['modelo']}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text('Ano: ${veiculo['ano']}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text('Placa: ${veiculo['placa']}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _deletarVeiculo,
                  child: Text('Excluir Veículo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent, // Cor de fundo do botão
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Abastecimento(veiculoId: widget.veiculoId),
                      ),
                    );
                  },
                  child: Text('Registrar Abastecimento'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoricoAbastecimentos(veiculoId: widget.veiculoId),
                      ),
                    );
                  },
                  child: Text('Ver Histórico de Abastecimentos'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
