import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'tela_login.dart';
import 'tela_cadastro.dart';
import 'tela_adicionar_veiculo.dart';  // Adicionando a nova tela


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Abastecimento',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaLogin(),  // Tela inicial de login
      routes: {
        '/home': (context) => Home(),  // Tela de listagem de veículos
        '/adicionar_veiculo': (context) => AdicionarVeiculo(),  // Tela de cadastro de veículo
        '/login': (context) => TelaLogin(),
        '/cadastro': (context) => TelaCadastro(),
      },
    );
  }
}
