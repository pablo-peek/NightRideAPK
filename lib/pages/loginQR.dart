import 'dart:convert'; // Importar dart:convert para jsonDecode

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboardRaceOne.dart'; // Asegúrate de importar la página


class QRLoginPage extends StatefulWidget {
  @override
  _QRLoginPageState createState() => _QRLoginPageState();
}

class _QRLoginPageState extends State<QRLoginPage> {
  String qrCodeResult = "No se ha escaneado ningún código QR";
  TokenObject? tokenObject;

  void scanQRCode() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRView(
          onDetect: (barcodeCapture) async {
            final barcode = barcodeCapture.barcodes.first;
            if (barcode.rawValue != null) {
              setState(() {
                qrCodeResult = barcode.rawValue!;
                // Asumimos que el valor escaneado es un JSON
                final Map<String, dynamic> parsedData =
                    jsonDecode(qrCodeResult); // Aquí se usa jsonDecode
                String username = parsedData['username'];
                String token = parsedData['token'];
                tokenObject = TokenObject(username: username, token: token);
              });

              // Guardar username y token
              await saveToken(tokenObject!.username, tokenObject!.token);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardRaceOnePageState()),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> saveToken(String username, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('token', token);
  }

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
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Escanear código QR"),
        onPressed: () {
          scanQRCode();
        },
      ),
      body: Center(
        child: Text(tokenObject != null
            ? 'Token: ${tokenObject!.token}'
            : qrCodeResult),
      ),
    );
  }
}

class QRView extends StatelessWidget {
  final Function(BarcodeCapture) onDetect;

  QRView({required this.onDetect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Escanear código QR"),
      ),
      body: MobileScanner(
        onDetect: (barcodeCapture) {
          onDetect(barcodeCapture);
        },
      ),
    );
  }
}

class TokenObject {
  final String username;
  final String token;

  TokenObject({required this.username, required this.token});

  @override
  String toString() {
    return 'TokenObject{username: $username, token: $token}';
  }
}
