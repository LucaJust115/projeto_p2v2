import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TelaPerfil extends StatefulWidget {
  @override
  _TelaPerfilState createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;

  bool _isLoggedOut = false; // Flag para controlar se o usuário está logado ou não

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _emailController.text = _user.email ?? '';
  }

  // Função para alterar a senha
  Future<void> _alterarSenha() async {
    try {
      String novaSenha = _senhaController.text;
      if (novaSenha.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Digite uma nova senha!')),
        );
        return;
      }
      await _user.updatePassword(novaSenha);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Senha alterada com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao alterar a senha: ${e.toString()}')),
      );
    }
  }

  // Função para deslogar e voltar à tela de login
  Future<void> _voltarAoLogin() async {
    await _auth.signOut();
    setState(() {
      _isLoggedOut = true; // Define a flag como true para mostrar o botão "Voltar ao Login"
    });
    Navigator.pushReplacementNamed(context, '/login'); // Navega para a tela de login
  }

  // Função para voltar para a tela Home sem fazer logout
  void _voltarParaHome() {
    Navigator.pushReplacementNamed(context, '/home'); // Navega para a tela home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              readOnly: true, // O usuário não pode editar o email
            ),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Nova Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _alterarSenha,
              child: Text('Alterar Senha'),
            ),
            SizedBox(height: 20),
            // Exibe o botão "Voltar ao Login" após o logout ou alteração de senha
            ElevatedButton(
              onPressed: _voltarAoLogin,
              child: Text('Voltar ao Login'),
            ),
            SizedBox(height: 20),
            // Botão "Voltar à Home", sem fazer logout
            ElevatedButton(
              onPressed: _voltarParaHome,
              child: Text('Voltar à Home'),
            ),
            if (_isLoggedOut) ...[
              // Este botão será mostrado após o logout
              Text('Você foi deslogado!'),
            ],
          ],
        ),
      ),
    );
  }
}
