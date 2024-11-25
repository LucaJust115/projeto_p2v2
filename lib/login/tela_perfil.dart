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
      backgroundColor: Colors.grey[100], // Cor de fundo consistente
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Colors.blueAccent, // Cor da AppBar consistente
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
              ),
              readOnly: true, // O usuário não pode editar o email
            ),
            SizedBox(height: 20),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(
                labelText: 'Nova Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _alterarSenha,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Alterar Senha'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _voltarAoLogin,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Voltar ao Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _voltarParaHome,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Voltar à Home'),
            ),
            if (_isLoggedOut) ...[
              Text('Você foi deslogado com sucesso!', style: TextStyle(color: Colors.green)),
            ],
          ],
        ),
      ),
    );
  }
}
