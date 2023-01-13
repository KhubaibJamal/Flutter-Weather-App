import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/Models/weather_model.dart';

class WeatherServices {
  Future<WeatherModel> fetchWeatherData() async {
    final response = await http.get(
      Uri.parse(
          'http://api.weatherapi.com/v1/forecast.json?key=f63cdb0138834263bb8144613231201&q=karachi&days=6&aqi=no&alerts=no'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
}
