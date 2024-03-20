import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // The location name for the UI
  late String time; // The time in that location, initialized later
  String flag; // URL to an asset flag icon
  String url; // Location URL for the API endpoint
  late bool isDaytime; // True if daytime, false if night, initialized later

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      var response = await http
          .get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      print('data' + data.toString());

      // Get properties
      DateTime now = DateTime.parse(data['datetime']);
      String offset = data['utc_offset'];
      bool isDst = data['dst'];

      int offsetHours = int.parse(offset.substring(1, 3));
      int offsetMinutes = int.parse(offset.substring(4, 6));
      if (offset.startsWith('-')) {
        offsetHours = -offsetHours;
        offsetMinutes = -offsetMinutes;
      }

      now = now.add(Duration(hours: offsetHours, minutes: offsetMinutes));

      // if (isDst) {
      //   int dstOffsetSeconds = data['dst_offset'];
      //   Duration dstOffset = Duration(seconds: dstOffsetSeconds);
      //   now = now.add(dstOffset);
      // }

      // Set the time property
      isDaytime =
          now.hour >= 6 && now.hour < 20; // Adjusting the range for daytime
      time =
          DateFormat.jm().format(now); // Format the time in a readable format
    } catch (e) {
      print('Caught error: $e');
      time = 'could not get time data';
      isDaytime = false; // Default value in case of an error
    }
  }
}
