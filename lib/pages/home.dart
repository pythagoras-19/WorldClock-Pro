import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  bool isUpdated = false; // Flag to track if data is updated.

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeData = ModalRoute.of(context)?.settings.arguments as Map?;

    // Only update data from route if it hasn't been updated already.
    if (!isUpdated && routeData != null && routeData.isNotEmpty) {
      setState(() {
        data = routeData;
        print('Data updated from didChangeDependencies: $data');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String bgImage = data['isDaytime'] == true ? 'day.png' : 'night.png';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    if (result != null && result is Map) {
                      setState(() {
                        data = Map.from(result);
                        isUpdated = true; // Mark as updated to prevent overwriting.
                        print('Data updated from button: $data');
                      });
                    }
                  },
                  icon: const Icon(Icons.edit_location),
                  label: const Text('Edit Location'),
                ),
                const SizedBox(height: 20),
                Text(
                  data['location'] ?? 'Unknown location',
                  style: TextStyle(
                    fontSize: 28,
                    color: data['isDaytime'] == true ? Colors.black : Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  data['time'] ?? 'Unknown time',
                  style: TextStyle(
                    fontSize: 66,
                    color: data['isDaytime'] == true ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
