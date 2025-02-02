import 'dart:async';
import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

import 'package:povedi_me_app/models/weather_forecast.dart';
import 'package:povedi_me_app/services/weather_service.dart';

class WeatherForecastVersion2 extends StatefulWidget {
  const WeatherForecastVersion2({super.key});

  @override
  State<WeatherForecastVersion2> createState() =>
      _WeatherForecastVersion2State();
}

class _WeatherForecastVersion2State extends State<WeatherForecastVersion2> {
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
          isScrollControlled: true,
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
                    Text(
                      "Prognoza za Koprivnicu",
                      style: AppTextStyles.wfBottomModalTitle(context),
                    ),
                    const SizedBox(height: 16),
                    ...weatherData!.forecast.map(
                      (forecast) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  forecast.time,
                                  style:
                                      AppTextStyles.wfBottomModalData(context),
                                ),
                                Image.network(
                                  'https://openweathermap.org/img/wn/${forecast.weatherIcon}@2x.png',
                                  width: 40,
                                  height: 40,
                                ),
                                Text(
                                  '${forecast.temperature.toStringAsFixed(1)}°C',
                                  style:
                                      AppTextStyles.wfBottomModalData(context),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Dodatne informacije:",
                      style: AppTextStyles.wfBottomModalAdditionalData(context),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Osjećaj temperature: ${weatherData!.feelsLike.toStringAsFixed(1)}°C",
                            style: AppTextStyles.wfBottomModalData(context),
                          ),
                          Text(
                            "Vlaga: ${weatherData!.humidity}%",
                            style: AppTextStyles.wfBottomModalData(context),
                          ),
                          Text(
                            "Brzina vjetra: ${(weatherData!.windSpeed * 3.6).toStringAsFixed(1)} km/h",
                            style: AppTextStyles.wfBottomModalData(context),
                          ),
                        ],
                      ),
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
        child: Container(
          // padding: EdgeInsets.all(8.0),
          // decoration: BoxDecoration(
          //   color: Colors.black.withOpacity(0.6),
          //   borderRadius: BorderRadius.circular(12),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weatherData!.cityName,
                          style: AppTextStyles.wfHomeTitle(context),
                        ),
                        const SizedBox(height: 8),
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
                              style: AppTextStyles.wfHomeTemperature(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Max: ${weatherData!.maxTemp.toStringAsFixed(1)}°',
                            style:
                                AppTextStyles.wfHomeTemperatureMinMax(context),
                          ),
                          Text(
                            'Min: ${weatherData!.minTemp.toStringAsFixed(1)}°',
                            style:
                                AppTextStyles.wfHomeTemperatureMinMax(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: weatherData!.forecast.map((forecast) {
                    return Column(
                      children: [
                        Text(
                          forecast.time,
                          style: AppTextStyles.wfHomeHourly(context),
                        ),
                        Image.network(
                          'https://openweathermap.org/img/wn/${forecast.weatherIcon}@2x.png',
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          '${forecast.temperature.toStringAsFixed(1)}°',
                          style: AppTextStyles.wfHomeHourly(context),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
