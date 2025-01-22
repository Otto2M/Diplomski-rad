import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/widgets/favorite_places_list.dart';

class FavoritePlacesTabScreen extends ConsumerWidget {
  const FavoritePlacesTabScreen({
    super.key,
    required this.title,
    required this.favoritePlaces,
  });

  final String title;
  final List<Place> favoritePlaces;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget content = const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Oh ne...'),
          SizedBox(height: 16),
          Text('Još nemate popis omiljenih mjesta.'),
        ],
      ),
    );

    if (favoritePlaces.isNotEmpty) {
      content = FavoritePlacesList(
        favoritePlaces: favoritePlaces,
        title: title,
      );
    }

    return Scaffold(
      body: content,
    );
  }
}
