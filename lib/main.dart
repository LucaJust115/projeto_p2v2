import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'tela_login.dart';
import 'tela_cadastro.dart';


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
      home: TelaLogin(),  // Define a TelaLogin como a tela inicial
      routes: {
        //criar a tela home '/home': (context) => Home(),
        '/login': (context) => TelaLogin(),
        '/cadastro': (context) => TelaCadastro(),

      },
    );
  }
}
