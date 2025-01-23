import 'package:flutter/material.dart';
import 'package:povedi_me_app/data/dummy_data.dart';
import 'package:povedi_me_app/widgets/places_by_category.dart';

class UpcomingEvents extends StatelessWidget {
  const UpcomingEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 0,
          ),
          child: Text('Nadolazeće manifestacije'),
        ),
        PlacesByCategory(place: availablePlaces[0]),
      ],
    );
  }
}
