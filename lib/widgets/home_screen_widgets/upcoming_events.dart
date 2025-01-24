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
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 0,
          ),
          child: Text('Nadolazeće manifestacije'),
        ),
        //
        //ovdje bi trebalo pozvati sva mjesta place u bazu dodati atribut
        //datum i filtrirati odmah SAMO manifestacije prema datumu te ih prikazati
        //
        PlacesByCategory(place: availablePlaces[0]),
      ],
    );
  }
}
