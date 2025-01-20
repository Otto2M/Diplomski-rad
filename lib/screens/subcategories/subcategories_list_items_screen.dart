import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/models/category.dart';
import 'package:povedi_me_app/providers/places_provider.dart';
import 'package:povedi_me_app/screens/subcategories/place_item_details_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class SubcategoriesListItemsScreen extends ConsumerWidget {
  const SubcategoriesListItemsScreen({
    super.key,
    required this.subcategory,
  });

  final Subcategory subcategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsyncValue = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(subcategory.title),
      ),
      body: placesAsyncValue.when(
        data: (places) {
          final filteredPlacesBySubcategories = places
              .where((place) => place.subcategoryId == subcategory.id)
              .toList();

          return ListView.builder(
            itemCount: filteredPlacesBySubcategories.length,
            itemBuilder: (context, index) {
              final place = filteredPlacesBySubcategories[index];

              //
              //IZDVOJITI OVAJ CARD U POSEBAN WIDGET I KORISTITI GA NA 2 MJESTA
              //

              //vrati prikaz s karticama i detaljima
              return Card(
                color: Colors.blueGrey,
                margin: const EdgeInsets.all(20),
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.zero),
                elevation: 5,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PlaceItemDetailsScreen(
                          placeWithDetails: place,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          FadeInImage(
                            placeholder: MemoryImage(kTransparentImage),
                            image: const AssetImage(
                                'assets/images/povedi_me_logo.png'),
                            fit: BoxFit.cover,
                            height: 150,
                            width: 150,
                          ),
                          Container(
                            color: Colors.black54,
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 30),
                            child: Column(
                              children: [
                                Text(
                                  place.title,
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                const Text('Recenzija'),
                                //const PlaceItemInfoReview(icon: Icons.star),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Greška: $error')),
      ),
    );
  }
}
