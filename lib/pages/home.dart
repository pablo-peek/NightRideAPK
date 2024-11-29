import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:nightride/pages/login.dart';
import 'dart:convert'; // Importar dart:convert para jsonDecode

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboardRaceOne.dart'; // Asegúrate de importar la página

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TokenObject? tokenObject;
  String qrCodeResult = '';

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
              
              await saveToken(tokenObject!.username, tokenObject!.token);
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
    print('Token guardado: $token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardRaceOnePageState(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Robust",
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isLargeScreen = constraints.maxWidth >
              600; // Para determinar si es una pantalla grande.

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Usando OpenContainer para la animación con la descripción del juego
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: OpenContainer(
                  closedColor: Colors.black,
                  openColor: Colors.black,
                  transitionType: ContainerTransitionType.fadeThrough,
                  closedElevation: 0,
                  openElevation: 0,
                  closedBuilder: (context, action) => Container(
                    height: isLargeScreen
                        ? 300
                        : 200, // Ajuste según el tamaño de la pantalla
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/tipography.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  openBuilder: (context, action) => Scaffold(
                    appBar: AppBar(
                      title: Text("Sobre NightRide"),
                      backgroundColor: Colors.black,
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "NightRide es un emocionante juego de carreras de coches en 3D ambientado en una ciudad iluminada con luces de neón. "
                            "Sumérgete en la escena de las carreras clandestinas y compite contra hábiles rivales "
                            "para demostrar tu dominio. Con acción de alta velocidad y una jugabilidad intensa, "
                            "NightRide lleva las carreras al siguiente nivel.",
                            style: TextStyle(
                                fontSize: isLargeScreen ? 20 : 16,
                                fontStyle: FontStyle.italic),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 16),
                          Image.asset(
                            'assets/images/feature_2.png',
                            height: isLargeScreen ? 200 : 150,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "En una ciudad donde las luces iluminan las calles y la oscuridad esconde secretos, "
                            "las carreras ilegales son el corazón de la vida nocturna. Este mundo no es solo de velocidad; "
                            "es un campo de batalla donde los mejores compiten no solo por dinero, sino por respeto y dominio "
                            "en las sombras.",
                            style: TextStyle(
                                fontSize: isLargeScreen ? 20 : 16,
                                fontStyle: FontStyle.italic),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Botones de inicio de sesión
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shadowColor: Colors.purple,
                        elevation: 5,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginFormPage()),
                        );
                      },
                      child: Text(
                        "Iniciar sesión",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Bungee',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.tealAccent.shade700,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shadowColor: Colors.teal,
                        elevation: 5,
                      ),
                      onPressed: () {
                        scanQRCode();
                      },
                      child: Text(
                        "Iniciar sesión con QR",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Bungee',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Pie de página
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "© 2024 Todos los derechos reservados a Robust.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Bungee',
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
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
