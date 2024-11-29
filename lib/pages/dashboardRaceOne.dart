import 'package:flutter/material.dart';
import '../controllers/loginController.dart';
import '../controllers/racesController.dart';

class DashboardRaceOnePageState extends StatefulWidget {
  @override
  _DashboardRaceOnePageState createState() => _DashboardRaceOnePageState();
}

class _DashboardRaceOnePageState extends State<DashboardRaceOnePageState> {
  final LoginController _controller = LoginController();
  final RacesController _racesController = RacesController();
  int _selectedLimit = 20;
  int _selectedPage = 1;
  int _selectedRaceNumber = 1;
  List<Map<String, dynamic>> _racers = [];
  int _totalRacers = 0;

  @override
  void initState() {
    super.initState();
    _fetchRacers();
  }

  void _fetchRacers() async {
    List<dynamic> racersDynamic = await _racesController.getAllRacers(
      context,
      _selectedRaceNumber,
      _selectedPage,
      _selectedLimit,
    );
    List<Map<String, dynamic>> racers =
        racersDynamic.cast<Map<String, dynamic>>();

    // Verificar si el widget está montado antes de llamar a setState
    if (mounted) {
      setState(() {
        _racers = racers;
        _totalRacers = racers.length;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    int totalPages = (_totalRacers / _selectedLimit).ceil();

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
            padding: const EdgeInsets.only(right: 16.0),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Carrera $_selectedRaceNumber",
              style: TextStyle(
                fontFamily: 'Bungee',
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black12,
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text('Rank'),
                      ),
                      DataColumn(
                        label: Text('Jugador'),
                      ),
                      DataColumn(
                        label: Text('Tiempo'),
                      ),
                    ],
                    rows: _racers.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> racer = entry.value;
                      bool isCurrentUser = racer['isCurrentUser'] ?? false;
                      TextStyle textStyle = isCurrentUser
                          ? TextStyle(fontWeight: FontWeight.bold)
                          : TextStyle(fontWeight: FontWeight.normal);
                      return DataRow(cells: [
                        DataCell(Text((index + 1 + (_selectedPage - 1) * _selectedLimit).toString(), style: textStyle)), // Mostrar el índice + 1 como Rank
                        DataCell(Text(racer['username'], style: textStyle)),
                        DataCell(Text(racer['races'][0]['formattedBestTime'], style: textStyle)),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: PopupMenuButton<int>(
                        onSelected: (value) {
                          setState(() {
                            _selectedLimit = value;
                            _selectedPage = 1; // Resetear a la primera página
                            _fetchRacers();
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return [20, 40, 100].map((int choice) {
                            return PopupMenuItem<int>(
                              value: choice,
                              child: Text(choice.toString()),
                            );
                          }).toList();
                        },
                        child: ElevatedButton(
                          onPressed: null,
                          child: Text('Límite ($_selectedLimit)'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_selectedPage > 1) {
                              _selectedPage--;
                              _fetchRacers();
                            }
                          });
                        },
                        child: Text('Página Anterior'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_selectedPage < totalPages) {
                              _selectedPage++;
                              _fetchRacers();
                            }
                          });
                        },
                        child: Text('Página Siguiente'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedRaceNumber = _selectedRaceNumber == 1 ? 2 : 1;
                      _selectedPage = 1; // Resetear a la primera página
                      _fetchRacers();
                    });
                  },
                  child: Text(_selectedRaceNumber == 1 ? 'Ir a Carrera 2' : 'Ir a Carrera 1'),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            color: Colors.grey.shade900,
            child: Text(
              "Todos los derechos reservados © Robust",
              style: TextStyle(
                fontFamily: 'Bungee',
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}