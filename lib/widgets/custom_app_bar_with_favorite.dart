import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/assets.dart';

import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/providers/favorites_provider.dart';
import 'package:povedi_me_app/services/favorite_place_service.dart';

class CustomAppBarWithFavorite extends ConsumerWidget {
  const CustomAppBarWithFavorite({
    super.key,
    required this.onBack,
    required this.place,
  });

  final VoidCallback onBack;
  final Place place;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePlaces = ref.watch(favoritePlacesProvider);
    final isFavorite = favoritePlaces.any((p) => p.id == place.id);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onBack,
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
          ),
          iconSize: 50,
        ),
        IconButton(
          onPressed: () {
            FavoritePlacesService.toggleFavoriteStatus(
              context: context,
              ref: ref,
              place: place,
            );
          },
          icon: Image.asset(
            isFavorite ? Assets.iRedHeart : Assets.iBorderRedHeart,
            width: 65,
            height: 65,
          ),
          key: ValueKey(isFavorite),
        ),
      ],
    );
  }
}
