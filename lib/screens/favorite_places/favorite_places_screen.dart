import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/widgets/favorite_places_list.dart';

class FavoritePlacesTabScreen extends ConsumerWidget {
  const FavoritePlacesTabScreen({
    super.key,
    required this.favoritePlaces,
  });

  final List<Place> favoritePlaces;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Oh ne...',
            style: AppTextStyles.description(context),
          ),
          const SizedBox(height: 16),
          Text(
            'Još nemate popis omiljenih mjesta.',
            style: AppTextStyles.description(context),
          ),
        ],
      ),
    );

    if (favoritePlaces.isNotEmpty) {
      content = FavoritePlacesList(
        favoritePlaces: favoritePlaces,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: content,
      ),
    );
  }
}
