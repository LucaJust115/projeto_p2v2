import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_p2v2/drawer/home.dart';

import '../veiculo/tela_adicionar_veiculo.dart';
import 'tela_cadastro.dart';

class TelaLogin extends StatefulWidget {
  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final FirebaseAuth _autenticacao = FirebaseAuth.instance;

  Future<void> _logar() async {
    final String email = _emailController.text.trim();
    final String senha = _senhaController.text.trim();

    if (email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await _autenticacao.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login realizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      String erro;
      if (e.code == 'user-not-found') {
        erro = 'Usuário não encontrado!';
      } else if (e.code == 'wrong-password') {
        erro = 'Senha incorreta!';
      } else if (e.code == 'invalid-email') {
        erro = 'E-mail inválido!';
      } else if (e.code == 'user-disabled') {
        erro = 'Usuário desativado!';
      } else {
        erro = 'Senha ou Email incorreto!';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(erro),
          backgroundColor: Colors.red,
        ),
      );
    }
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey[100], // Mudança na cor de fundo
        appBar: AppBar(
          title: Text("Login"),
          backgroundColor: Colors.blueAccent, // Mudança na cor do AppBar
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Campo de email
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Campo de senha
                  TextField(
                    controller: _senhaController,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _logar,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 100, vertical: 20),
                      backgroundColor: Colors.blueAccent,
                      // Cor do botão
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Login', style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaCadastro()),
                      );
                    },
                    child: Text('Criar uma conta'),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }