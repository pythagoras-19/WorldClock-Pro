import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeData = ModalRoute.of(context)?.settings.arguments;
    if (routeData != null) {
      // Ensure the data is a Map before assigning it
      try {
        data = routeData as Map;
        if (kDebugMode) {
          print(data);
        }
      } catch (e) {
        // Handle the case where data is not a Map
        if (kDebugMode) {
          print('Data is not in the expected format: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( // Center the Column itself
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center the children horizontally
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/choose_location');
                },
                icon: Icon(Icons.edit_location),
                label: Text('Edit Location'),
              ),
              SizedBox(height: 20),
              Text(
                data['location'] ?? 'Unknown location', // Displaying the location
                style: TextStyle(
                  fontSize: 28,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 20), // Space between location and time
              Text(
                data['time'] ?? 'Unknown time', // Displaying the time
                style: TextStyle(
                  fontSize: 66,
                ),
              ),
              // Add more widgets or use the 'data' map as needed
            ],
          ),
        ),
      ),
    );
  }
}
