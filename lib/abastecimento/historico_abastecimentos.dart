import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoricoAbastecimentos extends StatelessWidget {
  final String veiculoId;
  HistoricoAbastecimentos({required this.veiculoId});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> _getAbastecimentos() {
    return _firestore.collection('abastecimentos')
        .where('veiculoId', isEqualTo: veiculoId)
        .snapshots();
  }

  double calcularTotalGasto(List<DocumentSnapshot> abastecimentos) {
    return abastecimentos.fold(0, (soma, doc) => soma + double.parse(doc['total']));
  }

  double calcularTotalLitros(List<DocumentSnapshot> abastecimentos) {
    return abastecimentos.fold(0, (soma, doc) => soma + double.parse(doc['quantidade']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Histórico de Abastecimentos')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getAbastecimentos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
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
                Text('Total Gasto: R\$ $totalGasto'),
                Text('Total Litros: $totalLitros L'),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: abastecimentos.length,
                    itemBuilder: (context, index) {
                      var abastecimento = abastecimentos[index];
                      return ListTile(
                        title: Text('Data: ${abastecimento['data'].toDate()}'),
                        subtitle: Text('Total: R\$ ${abastecimento['total']}'),
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
