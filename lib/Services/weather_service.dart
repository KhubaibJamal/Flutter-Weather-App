import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/Models/weather_model.dart';

class WeatherServices {
  // List<WeatherModel> weatherList = [];
  Future<WeatherModel> fetchWeatherData() async {
    final response = await http.get(
      Uri.parse(
          'http://api.weatherapi.com/v1/forecast.json?key=f63cdb0138834263bb8144613231201&q=karachi&days=6&aqi=no&alerts=no'),
    );

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(data);
      // print(response.statusCode);

      // used when want data in list form
      // for (var i in data) {
      //   weatherList.add(WeatherModel.fromJson(i));
      // }

      return WeatherModel.fromJson(data);
      // return weatherList;
    } else {
      throw Exception('Error');
    }
  }
}
