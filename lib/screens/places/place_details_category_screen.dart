import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/providers/image_storage_provider.dart';
import 'package:povedi_me_app/services/favorite_place_service.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/providers/favorites_provider.dart';

class PlaceDetailsCategoryScreen extends ConsumerWidget {
  const PlaceDetailsCategoryScreen({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePlaces = ref.watch(favoritePlacesProvider);
    final isFavorite = favoritePlaces.contains(place);

    final imagesAsyncValue = ref.watch(folder1ImagesProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          bottom: 30,
          left: 30,
          right: 30,
          top: 15,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
                      icon: Icon(
                        isFavorite ? Icons.star : Icons.star_border,
                        key: ValueKey(isFavorite),
                      ),
                      iconSize: 40,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(place.title),
                const SizedBox(height: 20),
                Text(place.description),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: place.imageUrl.length, // Broj slika
                  itemBuilder: (context, index) {
                    final imagesUrl = place.imageUrl[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        imagesUrl,
                        fit: BoxFit.cover,
                        height: 120,
                        width: 150,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
