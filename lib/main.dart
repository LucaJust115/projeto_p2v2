// main.dart

import 'package:flutter/material.dart';
import 'package:projeto_p2v2/login/tela_login.dart';
import 'package:projeto_p2v2/veiculo/detalhes_veiculo.dart';
import 'package:projeto_p2v2/veiculo/tela_adicionar_veiculo.dart';
import 'package:projeto_p2v2/drawer/home.dart';
import 'package:projeto_p2v2/abastecimento/historico_abastecimentos.dart';
import 'package:projeto_p2v2/abastecimento/tela_abastecimento.dart';
import 'package:projeto_p2v2/login/tela_perfil.dart';
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
      initialRoute: '/',  // Define a rota inicial para a tela de login
      routes: {
        '/': (context) => TelaLogin(),  // Rota para a tela de login
        '/home': (context) => Home(),  // Rota para a tela inicial
        '/login': (context) => TelaLogin(),  // Rota para o login (não muito necessário, pois já está configurado como inicial)
        '/perfil': (context) => TelaPerfil(),  // Rota para a tela de perfil
        '/adicionar_veiculo': (context) => AdicionarVeiculo(),  // Rota para adicionar veículo
        '/detalhes_veiculo': (context) => DetalhesVeiculo(veiculoId: ''),  // Rota para detalhes do veículo
        '/meus_veiculos': (context) => Home(),  // Rota para a tela de veículos
        '/historico_abastecimentos': (context) => HistoricoAbastecimentos(
            veiculoId: ModalRoute.of(context)!.settings.arguments as String),
        '/abastecimento': (context) => Abastecimento(
            veiculoId: ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }
}
