import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String data = 'Loading Screen';
  String time = 'Loading';

  void setUpWorldTime() async {
    WorldTime instance = WorldTime(location: 'Berlin',
        flag: 'germany.png', url: 'Europe/Berlin', time: '', isDaytime: true);

    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
    });
    if (kDebugMode) {
      print(instance.time);
    }
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
