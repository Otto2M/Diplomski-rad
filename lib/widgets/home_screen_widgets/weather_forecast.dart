import 'dart:async';

import 'package:flutter/material.dart';
import 'package:povedi_me_app/models/weather_forecast.dart';
import 'package:povedi_me_app/services/weather_service.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({super.key});

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  final WeatherService _weatherService = WeatherService();
  Weather? weatherData;
  Timer? _timer;
  final String city = "Koprivnica";

  @override
  void initState() {
    super.initState();
    fetchWeatherData();

    // Periodično osvježavanje svakih 10 minuta
    _timer = Timer.periodic(const Duration(minutes: 10), (timer) {
      fetchWeatherData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetchWeatherData() async {
    try {
      final data = await _weatherService.fetchWeather(city);
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      print("Error fetching weather data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weatherData!.cityName,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.network(
                    'https://openweathermap.org/img/wn/${weatherData!.weatherIcon}@2x.png',
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '${weatherData!.temperature.toStringAsFixed(1)}°',
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Max: ${weatherData!.maxTemp.toStringAsFixed(1)}°',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Min: ${weatherData!.minTemp.toStringAsFixed(1)}°',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weatherData!.forecast.map((forecast) {
              return Column(
                children: [
                  Text(
                    forecast.time,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Image.network(
                    'https://openweathermap.org/img/wn/${forecast.weatherIcon}@2x.png',
                    width: 30,
                    height: 30,
                  ),
                  Text(
                    '${forecast.temperature.toStringAsFixed(1)}°',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
