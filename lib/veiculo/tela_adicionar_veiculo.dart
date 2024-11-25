import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdicionarVeiculo extends StatefulWidget {
  @override
  _AdicionarVeiculoState createState() => _AdicionarVeiculoState();
}

class _AdicionarVeiculoState extends State<AdicionarVeiculo> {
  final _nomeController = TextEditingController();
  final _modeloController = TextEditingController();
  final _anoController = TextEditingController();
  final _placaController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para adicionar um veículo ao Firestore
  Future<void> _adicionarVeiculo() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('veiculos').add({
        'nome': _nomeController.text,
        'modelo': _modeloController.text,
        'ano': _anoController.text,
        'placa': _placaController.text,
        'userId': user.uid, // Associa o veículo ao ID do usuário
      });

      // Redireciona para a tela Home após adicionar o veículo
      Navigator.pushReplacementNamed(context, '/home'); // Substitui a tela atual pela Home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Veículo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome do Veículo'),
            ),
            TextField(
              controller: _modeloController,
              decoration: InputDecoration(labelText: 'Modelo'),
            ),
            TextField(
              controller: _anoController,
              decoration: InputDecoration(labelText: 'Ano'),
            ),
            TextField(
              controller: _placaController,
              decoration: InputDecoration(labelText: 'Placa'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _adicionarVeiculo, // Adiciona o veículo e redireciona
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
