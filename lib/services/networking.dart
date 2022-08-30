import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Networking{
final uri;
Networking(@required this.uri);
  Future GetWeatherData() async {
    http.Response response = await http.get(Uri.parse(
        uri));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
      
    }else{
      print (response.statusCode);
    }
  }
}