import 'package:flutter/material.dart';

import '../veiculo/tela_adicionar_veiculo.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                // Você pode adicionar mais detalhes aqui, como e-mail do usuário logado
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_car),
            title: Text('Meus Veículos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/meus_veiculos');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Adicionar Veículo'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AdicionarVeiculo()), // Navegação para AdicionarVeiculo
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Histórico de Abastecimentos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/historico_abastecimentos');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/perfil');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
