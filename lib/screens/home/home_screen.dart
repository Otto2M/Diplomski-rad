import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/screens/search_bar/filtered_places_list.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/general_ai.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/perfect_day.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/upcoming_events/upcoming_events.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/weather_forecast_v2.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const FilteredPlacesList(),
                  const GeneralAi(),
                  const SizedBox(height: 10),
                  const WeatherForecastVersion2(),
                  const SizedBox(height: 10),
                  const UpcomingEvents(),
                  const PerfectDay(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
