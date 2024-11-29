import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                tokenObject = TokenObject(token: qrCodeResult);
              });
              await saveToken(tokenObject!.token);
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
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
        child: Text(tokenObject != null ? 'Token: ${tokenObject!.token}' : qrCodeResult),
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
  final String token;

  TokenObject({required this.token});

  @override
  String toString() {
    return 'TokenObject{token: $token}';
  }
}