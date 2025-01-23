import 'package:flutter/material.dart';

import 'package:povedi_me_app/widgets/home_screen_widgets/general_ai.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/perfect_day.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/upcoming_events.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/weather_forecast.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GeneralAi(),
              SizedBox(height: 10),
              //WeatherForecast(),
              SizedBox(height: 10),
              UpcomingEvents(),
              PerfectDay(),
            ],
          ),
        ),
      ),
    );
  }
}
