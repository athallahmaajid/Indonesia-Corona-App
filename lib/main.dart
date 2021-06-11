import 'package:flutter/material.dart';
import 'package:corona_app/main_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

Future<dynamic> connectToAPI({bool province = false}) async
{
  String apiURL = (province) ? 'https://api.kawalcorona.com/indonesia/provinsi' : 'https://api.kawalcorona.com/indonesia';
  var apiResult = await http.get(Uri.parse(apiURL));
  var jsonObject = (province) ? json.decode(apiResult.body) : json.decode(apiResult.body)[0];
  var covidData = (province) ? jsonObject : (jsonObject as Map<String, dynamic>);

  return covidData;
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainScreen());
  }
}