class Weather {
  Weather({
    required this.cityName,
    required this.temperature,
    required this.minTemp,
    required this.maxTemp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.weatherMain,
    required this.description,
    required this.weatherIcon,
    required this.forecast,
  });

  final String cityName;
  final double temperature;
  final double minTemp;
  final double maxTemp;
  final double feelsLike;
  final double humidity;
  final double windSpeed;
  final String weatherMain;
  final String description;
  final String weatherIcon;
  final List<Forecast> forecast;

  factory Weather.fromJson(Map<String, dynamic> json) {
    final currentWeather = json['list'][0];
    final cityName = json['city']['name'];
    final forecastList = (json['list'] as List).sublist(1, 6).map((item) {
      return Forecast.fromJson(item);
    }).toList();

    return Weather(
      cityName: cityName,
      temperature: (currentWeather['main']['temp'] as num).toDouble(),
      minTemp: (currentWeather['main']['temp_min'] as num).toDouble(),
      maxTemp: (currentWeather['main']['temp_max'] as num).toDouble(),
      feelsLike: (currentWeather['main']['feels_like'] as num).toDouble(),
      humidity: (currentWeather['main']['humidity'] as num).toDouble(),
      windSpeed: (currentWeather['wind']['speed'] as num).toDouble(),
      weatherMain: currentWeather['weather'][0]['main'],
      description: currentWeather['weather'][0]['description'],
      weatherIcon: currentWeather['weather'][0]['icon'],
      forecast: forecastList,
    );
  }
}

class Forecast {
  Forecast({
    required this.time,
    required this.temperature,
    required this.weatherIcon,
  });

  final String time;
  final double temperature;
  final String weatherIcon;

  factory Forecast.fromJson(Map<String, dynamic> json) {
    final time = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)
        .hour
        .toString()
        .padLeft(2, '0');
    return Forecast(
      time: '$time:00',
      temperature: (json['main']['temp'] as num).toDouble(),
      weatherIcon: json['weather'][0]['icon'],
    );
  }
}
