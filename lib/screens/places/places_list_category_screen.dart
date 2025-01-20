import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/providers/places_provider.dart';

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
      appBar: AppBar(
        title: Text(title),
      ),
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

          return ListView.builder(
            itemCount: filteredPlaces.length,
            itemBuilder: (context, index) {
              final place = filteredPlaces[index];
              return ListTile(
                leading: Image.network(
                  place.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(place.title),
                subtitle: Text(place.description),
                onTap: () {
                  // Možete dodati navigaciju na detaljni ekran mjesta
                },
              );
            },
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
