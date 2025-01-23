import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:povedi_me_app/models/weather_forecast.dart';

class WeatherService {
  final String apiKey = "506d5d5857a39eacabdc630a2caf6fd7";
  final String baseUrl = "https://api.openweathermap.org/data/2.5/forecast";

  Future<Weather> fetchWeather(String city) async {
    final url = Uri.parse('$baseUrl?q=$city&units=metric&appid=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Weather.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
