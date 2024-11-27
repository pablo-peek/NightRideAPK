import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:nightride/pages/login.dart';
import 'package:nightride/pages/loginQR.dart';

class HomePage extends StatelessWidget {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: OpenContainer(
              closedColor: Colors.black,
              openColor: Colors.black,
              transitionType: ContainerTransitionType.fadeThrough,
              closedElevation: 0,
              openElevation: 0,
              closedBuilder: (context, action) => Container(
                height: 300,
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
                        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 16),
                      Image.asset(
                        'assets/images/feature_2.png',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "En una ciudad donde las luces iluminan las calles y la oscuridad esconde secretos, "
                        "las carreras ilegales son el corazón de la vida nocturna. Este mundo no es solo de velocidad; "
                        "es un campo de batalla donde los mejores compiten no solo por dinero, sino por respeto y dominio "
                        "en las sombras.",
                        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
                      MaterialPageRoute(builder: (context) => LoginFormPage()),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QRLoginPage()),
                    );
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
      ),
    );
  }
}

