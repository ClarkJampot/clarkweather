import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_clima_flutter/services/location.dart';

class Networking{
  String apiKey = "436cd9f31c057432f5010497d05a8aeb";
  double temp=0;
  String data='',city='';
  int id=0;

  Future<String> getData() async{
    Location location = new Location();
    await location.getLocation();
    double lat = location.lat;
    double lon = location.lon;


    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric");
    Response response = await get(url);
    data = response.body;
    if(response.statusCode == 200){
      return data;
    }else{
      return "Error";
    }

  }

}