import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../veiculo/detalhes_veiculo.dart';
import 'drawer_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para buscar os veículos do usuário logado
  Stream<QuerySnapshot> _getVeiculos() {
    User? user = _auth.currentUser;
    if (user != null) {
      return _firestore
          .collection('veiculos')
          .where('userId', isEqualTo: user.uid)  // Filtra pelos veículos do usuário logado
          .snapshots();
    }
    return Stream.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Veículos'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getVeiculos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar veículos'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Nenhum veículo cadastrado.'));
          }

          // Exibe a lista de veículos
          var veiculos = snapshot.data!.docs;
          return ListView.builder(
            itemCount: veiculos.length,
            itemBuilder: (context, index) {
              var veiculo = veiculos[index];
              return ListTile(
                title: Text(veiculo['nome']),
                subtitle: Text('Modelo: ${veiculo['modelo']}'),
                onTap: () {
                  // Redireciona para a tela de detalhes do veículo
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalhesVeiculo(veiculoId: veiculo.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      drawer: DrawerWidget(veiculoId: '',),  // Usando o widget Drawer modularizado
    );
  }
}
