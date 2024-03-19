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
      // ensure the data is a Map before assigning it
      try {
        data = routeData as Map;
        if (kDebugMode) {
          print(data);
        }
      } catch (e) {
        // handle the case where data is not a Map
        if (kDebugMode) {
          print('Data is not in the expected format: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/choose_location');
              },
              icon: Icon(Icons.edit_location),
              label: Text('Edit Location'),
            ),
            // Add more widgets or use the 'data' map as needed
          ],
        ),
      ),
    );
  }
}
