import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoricoAbastecimentos extends StatelessWidget {
  final String? veiculoId;  // O ID do veículo para mostrar o histórico, pode ser nulo
  HistoricoAbastecimentos({this.veiculoId}) {
    print("Veículo ID recebido: $veiculoId"); // Verifique se o ID está sendo passado
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Função para pegar os abastecimentos do veículo específico ou todos os abastecimentos
  Stream<QuerySnapshot> _getAbastecimentos() {
    if (veiculoId != null && veiculoId!.isNotEmpty) {
      // Se o veiculoId foi fornecido, filtra pelo ID do veículo
      return _firestore.collection('abastecimentos')
          .where('veiculoId', isEqualTo: veiculoId) // Filtra pelo veiculoId
          .snapshots();
    } else {
      // Caso contrário, exibe todos os abastecimentos
      return _firestore.collection('abastecimentos').snapshots();
    }
  }

  // Função para obter o nome do veículo a partir do ID
  Future<String> _getNomeVeiculo(String veiculoId) async {
    var docSnapshot = await _firestore.collection('veiculos').doc(veiculoId).get();
    if (docSnapshot.exists) {
      return docSnapshot['nome']; // Retorna o nome do veículo
    }
    return 'Veículo não encontrado'; // Caso não encontre
  }

  // Calcula o total gasto com abastecimentos
  double calcularTotalGasto(List<DocumentSnapshot> abastecimentos) {
    return abastecimentos.fold(0, (soma, doc) => soma + double.parse(doc['total']));
  }

  // Calcula o total de litros abastecidos
  double calcularTotalLitros(List<DocumentSnapshot> abastecimentos) {
    return abastecimentos.fold(0, (soma, doc) => soma + double.parse(doc['quantidade']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Abastecimentos'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getAbastecimentos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Nenhum abastecimento registrado.'));
          }

          var abastecimentos = snapshot.data!.docs;
          double totalGasto = calcularTotalGasto(abastecimentos);
          double totalLitros = calcularTotalLitros(abastecimentos);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                if (veiculoId != null)
                  Text(
                    'Total Gasto: R\$ $totalGasto',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                if (veiculoId != null)
                  Text(
                    'Total Litros: $totalLitros L',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: abastecimentos.length,
                    itemBuilder: (context, index) {
                      var abastecimento = abastecimentos[index];
                      // Consulta o nome do veículo baseado no veiculoId
                      return FutureBuilder<String>(
                        future: _getNomeVeiculo(abastecimento['veiculoId']),
                        builder: (context, vehicleSnapshot) {
                          if (vehicleSnapshot.connectionState == ConnectionState.waiting) {
                            return ListTile(
                              title: Text('Data: ${abastecimento['data'].toDate()}'),
                              subtitle: Text('Total: R\$ ${abastecimento['total']}, Carro: Carregando...'),
                            );
                          }

                          if (vehicleSnapshot.hasError) {
                            return ListTile(
                              title: Text('Data: ${abastecimento['data'].toDate()}'),
                              subtitle: Text('Total: R\$ ${abastecimento['total']}, Carro: Erro ao carregar nome'),
                            );
                          }

                          String nomeVeiculo = vehicleSnapshot.data ?? 'Veículo não encontrado';
                          return ListTile(
                            title: Text('Data: ${abastecimento['data'].toDate()}'),
                            subtitle: Text('Total: R\$ ${abastecimento['total']}, Carro: $nomeVeiculo'),
                          );
                        },
                      );
                    },
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
