import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/screens/search_bar/filtered_places_list.dart';
import 'package:povedi_me_app/screens/search_bar/search_bar.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/general_ai.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/perfect_day.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/upcoming_events/upcoming_events.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/weather_forecast_v2.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
    // this.scaffoldKey,
  });

  // final GlobalKey<ScaffoldState>? scaffoldKey;

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
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 80.0,
              collapsedHeight: kToolbarHeight,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                background: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.menu_rounded,
                          size: 40,
                        ),
                        padding: const EdgeInsets.all(12.0),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                          // scaffoldKey!.currentState?.openDrawer();
                        },
                      ),
                      const Expanded(
                        child: CustomSearchBar(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const FilteredPlacesList(),
                  const GeneralAi(),
                  const SizedBox(height: 10),
                  //const WeatherForecast(),
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
