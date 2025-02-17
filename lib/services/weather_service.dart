import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:povedi_me_app/constants/keys.dart';
import 'package:povedi_me_app/models/weather_forecast.dart';

class WeatherService {
  final String apiKey = Keys.weatherApiKey;
  final String baseUrl = "https://api.openweathermap.org/data/2.5/forecast";

  Future<Weather> fetchWeather(String city) async {
    final url = Uri.parse('$baseUrl?q=$city&units=metric&appid=$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Weather.fromJson(jsonData);
      } else {
        return Future.error('Došlo je do greške pri dohvaćanju podataka.');
      }
    } on SocketException {
      return Future.error(
          'Nema internetske veze.\n Provjerite vezu i pokušajte ponovno.');
    } on FormatException {
      return Future.error(
          'Pogreška u formatu podataka.\n Molimo pokušajte ponovo kasnije.');
    } catch (e) {
      return Future.error(
          'Greška prilikom dohvaćanja podataka o vremenskoj prognozi!');
    }
  }
}
