import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDaytime;

  WorldTime({required this.location, required this.flag,
    required this.url, required this.time, required this.isDaytime});

  Future<void> getTime() async {
    try {
      Response response = await
        get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = now.toString();
    } catch (e) {
      if (kDebugMode) {
        print('Caught error: $e');
      }
      time = 'Could not get time data';
    }
  }
}