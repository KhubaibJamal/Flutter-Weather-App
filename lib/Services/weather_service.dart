import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/weather_model.dart';

class WeatherServices {
  // List<WeatherModel> weatherList = [];
  Future<WeatherModel> fetchWeatherData(String lat, String lon) async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=f82e826bfac980a6b653e036c9b5753e&units=metric'),
    );

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data);
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
