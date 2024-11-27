import 'package:flutter/material.dart';

class QRLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text(
              "Ingresar con QR",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Bungee',
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0, 
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
          ),
      body: Center(
        child: Text("QR Login Page Content"),
      ),
    );
  }
}