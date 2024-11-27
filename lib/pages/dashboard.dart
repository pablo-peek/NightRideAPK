import 'package:flutter/material.dart';
import '../controllers/loginController.dart';

class DashboardPage extends StatelessWidget {
  final LoginController _controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Marcador Global",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Bungee',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple.shade900,
                Colors.black,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // Añade un margen a la derecha
            child: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'logout') {
                  _controller.logout(context);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Text('Cerrar sesión'),
                  ),
                ];
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.deepPurple),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('Bienvenido al Dashboard'),
      ),
    );
  }
}