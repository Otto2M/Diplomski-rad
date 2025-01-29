import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/screens/search_bar/filtered_places_list.dart';
import 'package:povedi_me_app/screens/search_bar/search_bar.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/general_ai.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/perfect_day.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/upcoming_events/upcoming_events.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/weather_forecast_v2.dart';
import 'package:povedi_me_app/widgets/menu/app_drawer_menu.dart';

// GlobalKey za Scaffold
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: _scaffoldKey,
      //appBar: AppBar(),   // --- dodatni način korištenja vlastitog AppDrawer menu-a
      drawer: const AppDrawer(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                //CustomHamburgerMenu(),
                //AppDrawer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, size: 40),
                      padding: const EdgeInsets.all(12.0),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                    const Expanded(
                      child: CustomSearchBar(),
                    ),
                  ],
                ),
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
        ),
      ),
    );
  }
}
