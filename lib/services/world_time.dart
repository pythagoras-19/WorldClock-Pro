import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;  // The location name for the UI
  late String time; // The time in that location, initialized later
  String flag;      // URL to an asset flag icon
  String url;       // Location URL for the API endpoint
  late bool isDaytime; // True if daytime, false if night, initialized later

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      print("getTime called -------------------");
      // Make the request
      var response = await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // Get properties from data
      String datetime = data['datetime'];
      String offsetHours = data['utc_offset'].substring(1, 3);
      String offsetMinutes = data['utc_offset'].substring(4, 6); // Adding support for minutes in offset

      // Create DateTime object
      DateTime now = DateTime.parse(datetime);
      print('now: $now');
      now = now.add(Duration(hours: int.parse(offsetHours), minutes: int.parse(offsetMinutes))); // Adjust for full offset

      // Set the time property
      isDaytime = now.hour >= 6 && now.hour < 20; // Adjusting the range for daytime
      time = DateFormat.jm().format(now); // Format the time in a readable format
    } catch (e) {
      print('Caught error: $e');
      time = 'could not get time data';
      isDaytime = false; // default value in case of an error
    }
  }
}
