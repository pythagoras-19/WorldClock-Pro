import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:world_time/services/world_time.dart';

import 'package:http/http.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String data = 'Loading Screen';
  String time = 'Loading';

  void setUpWorldTime() async {
    WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin', time: '', isDaytime: true);
    await instance.getTime();
    print(instance.time);
    setState(() {
      time = instance.time;
    });
  }
  @override
  void initState() {
    super.initState();
    setUpWorldTime();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(time),
      ),
    );
  }
}
