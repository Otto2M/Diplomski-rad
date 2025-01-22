import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/providers/places_provider.dart';
import 'package:povedi_me_app/screens/places/shopping_places_screen.dart';
import 'package:povedi_me_app/widgets/places_by_category.dart';

class PlacesListCategoryScreen extends ConsumerWidget {
  const PlacesListCategoryScreen({
    super.key,
    required this.categoryId,
    required this.title,
  });

  final String categoryId;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsyncValue = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(),
      body: placesAsyncValue.when(
        data: (places) {
          final filteredPlaces =
              places.where((place) => place.categoryId == categoryId).toList();

          if (filteredPlaces.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Oh ne...'),
                  SizedBox(height: 16),
                  Text('Nema dostupnih mjesta za ovu kategoriju.'),
                  SizedBox(height: 16),
                  Text('Odaberite drugu kategoriju!'),
                ],
              ),
            );
          }

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
                  itemCount: filteredPlaces.length,
                  itemBuilder: (context, index) {
                    final place = filteredPlaces[index];

                    if (place is ShoppingPlace) {
                      return ShoppingPlacesScreen(place: place);
                    }
                    return PlacesByCategory(
                      place: place,
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Došlo je do greške: $error'),
        ),
      ),
    );
  }
}
