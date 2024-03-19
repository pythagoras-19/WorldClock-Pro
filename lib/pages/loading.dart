import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String data = 'Loading Screen';

  @override
  void initState() {
    super.initState();
    getTime();
  }

  void getTime() async {
    Response response = await
      http.get(Uri.parse('https://worldtimeapi.org/api/timezone/Europe/London'));
    Map data = jsonDecode(response.body);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(data),
      ),
    );
  }
}
