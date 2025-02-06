import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/providers/favorites_provider.dart';

class FavoritePlacesService {
  static void toggleFavoriteStatus({
    required BuildContext context,
    required WidgetRef ref,
    required Place place,
  }) async {
    final wasAdded = await ref
        .read(favoritePlacesProvider.notifier)
        .togglePlaceFavoriteStatus(place);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          wasAdded
              ? 'Mjesto dodano u omiljeno'
              : 'Mjesto uklonjeno iz omiljenog.',
        ),
      ),
    );
  }
}
