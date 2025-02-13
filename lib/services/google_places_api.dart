import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:povedi_me_app/constants/keys.dart';

Future<String?> fetchPlaceIdFromPlaceName({required String placeName}) async {
  final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$placeName%20Koprivnica&key=${Keys.googleApiKey}');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'] != null && data['results'].isNotEmpty) {
        final placeId = data['results'][0]['place_id'];

        //debugPrint("Dohvaćeni placeID : $placeId");
        return placeId;
      } else {
        debugPrint('No results found for coordinates.');
        return null;
      }
    } else {
      debugPrint('Failed to fetch place ID. Status: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    debugPrint('Error fetching Place ID: $e');
    return null;
  }
}

Future<Map<String, dynamic>> fetchWorkingHours(
    {required String placeId}) async {
  final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=opening_hours,rating&key=${Keys.googleApiKey}');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final openingHours = data['result']?['opening_hours'];
      final weekdayText = openingHours?['weekday_text'];
      final openNow = openingHours?['open_now'];
      final rating = data['result']?['rating'];

      final translatedHours = weekdayText != null
          ? (weekdayText as List).map((day) {
              return _translateWorkingHoursToCroatian(day);
            }).join('\n')
          : "Radno vrijeme nije dostupno.";

      return {
        "workingHours": translatedHours,
        "openNow": openNow ?? false,
        "rating": rating ?? 0.0,
      };
    } else {
      debugPrint(
          'Failed to fetch place details. Status: ${response.statusCode}');
      return {
        "workingHours": null,
        "openNow": false,
        "rating": 0.0,
      };
    }
  } catch (e) {
    debugPrint('Error fetching working hours: $e');
    return {
      "workingHours": null,
      "openNow": false,
      "rating": 0.0,
    };
  }
}

String _translateWorkingHoursToCroatian(String day) {
  const dayTranslations = {
    "Monday": "Ponedjeljak",
    "Tuesday": "Utorak",
    "Wednesday": "Srijeda",
    "Thursday": "Četvrtak",
    "Friday": "Petak",
    "Saturday": "Subota",
    "Sunday": "Nedjelja",
    "Closed": "Zatvoreno",
  };

  for (final entry in dayTranslations.entries) {
    day = day.replaceAll(entry.key, entry.value);
  }

  final timeRegex = RegExp(r'(\d+:\d+)\s*(AM|PM)');
  day = day.replaceAllMapped(timeRegex, (match) {
    final time = match.group(1)!;
    final period = match.group(2)!;
    final parts = time.split(':');
    var hours = int.parse(parts[0]);
    final minutes = parts[1];

    if (period == "PM" && hours != 12) {
      hours += 12;
    } else if (period == "AM" && hours == 12) {
      hours = 0;
    }

    return '${hours.toString().padLeft(2, '0')}:$minutes';
  });

  return day;
}
