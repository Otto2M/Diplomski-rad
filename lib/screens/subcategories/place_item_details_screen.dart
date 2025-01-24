import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/services/favorite_place_service.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/providers/favorites_provider.dart';

class PlaceItemDetailsScreen extends ConsumerWidget {
  const PlaceItemDetailsScreen({
    super.key,
    required this.placeWithDetails,
  });

  final PlaceWithDetails placeWithDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePlaces = ref.watch(favoritePlacesProvider);
    final isFavorite = favoritePlaces.contains(placeWithDetails);
    final List<String> images = placeWithDetails.imageUrl;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FavoritePlacesService.toggleFavoriteStatus(
                context: context,
                ref: ref,
                place: placeWithDetails,
              );
            },
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              key: ValueKey(isFavorite),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var imageUrl in images)
              Image.network(
                //
                // ---POPRAVITI KASNIJE ----
                //
                imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            Text(placeWithDetails.title),
            const SizedBox(height: 20),
            Text(placeWithDetails.address),
            const SizedBox(height: 20),
            // placeWithDetails.workingHours != null
            //     ? Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: placeWithDetails.workingHours!.entries
            //             .map((entry) => Text('${entry.key}: ${entry.value}'))
            //             .toList(),
            //       )
            //     : Text('No working hours available'),
            Text(
              placeWithDetails.workingHours != null
                  ? placeWithDetails.workingHours!.entries
                      .map((entry) => '${entry.key}: ${entry.value}')
                      .join('\n') // Svaki dan na novom redu
                  : 'No working hours available',
            ),
            const SizedBox(height: 20),
            Text(placeWithDetails.description),
            const SizedBox(height: 10),
            for (var review in placeWithDetails.reviews!) Text(review)
          ],
        ),
      ),
    );
  }
}
