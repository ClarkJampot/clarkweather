import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_clima_flutter/services/location.dart';

class Networking {
  String apiKey = "436cd9f31c057432f5010497d05a8aeb";

  Future<String> getLocationWeather() async {
    Location location = Location();
    await location.getLocation();
    double lat = location.lat;
    double lon = location.lon;

    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric");
    Response response = await get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Error";
    }
  }

  Future<String> getCityWeather(String cityName) async {
    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric");
    Response response = await get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Error";
    }
  }

  Future<String> fetchBackgroundImage(String prompt) async {
    final response = await get(
      Uri.parse('https://image.pollinations.ai/prompt/$prompt'),
    );

    if (response.statusCode == 200) {
      // Return the URL directly
      return response.request?.url.toString() ?? '';
    } else {
      throw Exception('Failed to load background image');
    }
  }
}
