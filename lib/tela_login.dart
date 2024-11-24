import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'tela_cadastro.dart';  // Importar tela de cadastro

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _senhaController.text,
      );
      Navigator.pushNamed(context, '/home');  // Redireciona para a tela Home após login
    } catch (e) {
      print(e);
    }
  }

  Future<void> _recuperarSenha() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      // Mostrar um alerta de sucesso ou erro
    } catch (e) {
      print(e);  // Tratar erros de recuperação de senha
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaCadastro()), // Redirecionar para tela de cadastro
                );
              },
              child: Text('Criar uma conta'),
            ),
            TextButton(
              onPressed: _recuperarSenha,
              child: Text('Esqueci a senha'),
            ),
          ],
        ),
      ),
    );
  }
}
