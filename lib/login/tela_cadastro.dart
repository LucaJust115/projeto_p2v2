import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _isLoading = false;
  String? _erroMensagem;

  Future<void> _cadastrar() async {
    setState(() {
      _isLoading = true;
      _erroMensagem = null;
    });

    try {
      String email = _emailController.text.trim();
      String senha = _senhaController.text;

      if (email.isEmpty || senha.isEmpty) {
        setState(() {
          _erroMensagem = 'Por favor, preencha todos os campos.';
          _isLoading = false;
        });
        return;
      }

      if (senha.length < 6) {
        setState(() {
          _erroMensagem = 'A senha deve ter pelo menos 6 caracteres.';
          _isLoading = false;
        });
        return;
      }

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Cadastro realizado com sucesso!'),
        backgroundColor: Colors.green,
      ));
      Navigator.pop(context); // Volta para a tela de login após o cadastro

    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
        if (e.code == 'email-already-in-use') {
          _erroMensagem = 'Este email já está cadastrado.';
        } else if (e.code == 'invalid-email') {
          _erroMensagem = 'Email inválido.';
        } else if (e.code == 'weak-password') {
          _erroMensagem = 'A senha é muito fraca.';
        } else {
          _erroMensagem = 'Erro: ${e.message}';
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _erroMensagem = 'Erro ao cadastrar: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Cadastro de Usuário"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
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
            if (_erroMensagem != null)
              Text(
                _erroMensagem!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _cadastrar,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 100, vertical: 20),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Cadastrar', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
