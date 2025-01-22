import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/providers/filter_subcategories_provider.dart';
import 'package:povedi_me_app/widgets/card_items.dart';
import 'package:povedi_me_app/widgets/places_by_category.dart';

class FavoritePlacesList extends ConsumerWidget {
  const FavoritePlacesList({
    super.key,
    required this.favoritePlaces,
    required this.title,
  });

  final List<Place> favoritePlaces;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 0,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Text(
            title.toUpperCase(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: favoritePlaces.length,
            itemBuilder: (context, index) {
              final favoritePlace = favoritePlaces[index];
              final subcategoryByPlace =
                  ref.watch(subcategoryForPlaceProvider(favoritePlace));

              // Prikaži dizajn za PlaceWithDetails ili Place
              if (favoritePlace is PlaceWithDetails) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subcategoryByPlace == null
                          ? ''
                          : subcategoryByPlace.title,
                    ),
                    const SizedBox(height: 10),
                    CardItems(
                      place: favoritePlace,
                      isInteractive: true,
                    ),
                  ],
                );
              } else {
                return PlacesByCategory(
                  place: favoritePlace,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
