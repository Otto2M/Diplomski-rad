import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/providers/filter_subcategories_provider.dart';
import 'package:povedi_me_app/widgets/card_items.dart';
import 'package:povedi_me_app/widgets/places_by_category.dart';

class FavoritePlacesList extends ConsumerWidget {
  const FavoritePlacesList({
    super.key,
    required this.favoritePlaces,
  });

  final List<Place> favoritePlaces;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Text(
              "Moji Favoriti".toUpperCase(),
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.categoryHeadline(context),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: favoritePlaces.length,
              itemBuilder: (context, index) {
                final favoritePlace = favoritePlaces[index];
                final subcategoryByPlace =
                    ref.watch(subcategoryForPlaceProvider(favoritePlace));

                if (favoritePlace is PlaceWithDetails) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                        child: Text(
                          subcategoryByPlace == null
                              ? ''
                              : subcategoryByPlace.title,
                          style:
                              AppTextStyles.favoriteScreenSubcategoryHedaline(
                                  context),
                        ),
                      ),
                      Center(
                        child: CardItems(
                          place: favoritePlace,
                          isInteractive: true,
                        ),
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
      ),
    );
  }
}
