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

  String getBackgroundImage(String weatherCondition) {
    if (weatherCondition.contains('clear')) {
      return 'assets/images/sunny_background.jpg';
    } else if (weatherCondition.contains('clouds')) {
      return 'assets/images/cloudy_background.jpg';
    } else if (weatherCondition.contains('rain')) {
      return 'assets/images/rainy_background.jpg';
    } else if (weatherCondition.contains('snow')) {
      return 'assets/images/snowy_background.jpg';
    } else {
      return 'assets/images/default_background.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (weatherData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    String weatherCondition = weatherData!.description.toLowerCase();
    String backgroundImage = getBackgroundImage(weatherCondition);

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImage),
                  fit: BoxFit.cover,
                ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Prognoza za Koprivnicu",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    ...weatherData!.forecast.map(
                      (forecast) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(forecast.time),
                              Image.network(
                                'https://openweathermap.org/img/wn/${forecast.weatherIcon}@2x.png',
                                width: 30,
                                height: 30,
                              ),
                              Text(
                                  '${forecast.temperature.toStringAsFixed(1)}°C'),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Dodatne informacije:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        //color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Osjećaj temperature: ${weatherData!.feelsLike.toStringAsFixed(1)}°C",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Vlaga: ${weatherData!.humidity}%",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Brzina vjetra: ${(weatherData!.windSpeed * 3.6).toStringAsFixed(1)} km/h",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
          //color: Colors.blue.shade700,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weatherData!.cityName,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 8),
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
                    const SizedBox(width: 8),
                    Text(
                      '${weatherData!.temperature.toStringAsFixed(1)}°',
                      style: const TextStyle(fontSize: 32, color: Colors.white),
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
            const SizedBox(height: 16),
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
      ),
    );
  }
}
