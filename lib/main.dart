import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import './pages/home.dart';
import 'pages/dashboardRaceOne.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const NightRide());
}

class NightRide extends StatelessWidget {
  const NightRide({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return snapshot.data == true ? DashboardRaceOnePageState() : HomePage();
          }
        },
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }
}