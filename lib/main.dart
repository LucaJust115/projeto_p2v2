// main.dart

import 'package:flutter/material.dart';
import 'package:projeto_p2v2/login/tela_login.dart';
import 'package:projeto_p2v2/veiculo/tela_adicionar_veiculo.dart';
import 'package:projeto_p2v2/drawer/home.dart';
import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => TelaLogin(),
        '/home': (context) => Home(),
        '/adicionar_veiculo': (context) => AdicionarVeiculo(),
        // Outras rotas podem ser registradas aqui
      },
    );
  }
}
