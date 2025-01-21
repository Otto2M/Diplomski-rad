import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/models/category.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/providers/places_provider.dart';
import 'package:transparent_image/transparent_image.dart';

//
// ---------------- NE KORISTI SE -----------------------
//

class SubcategoriesScreenController extends ConsumerWidget {
  const SubcategoriesScreenController({
    super.key,
    required this.subcategory,
  });

  final Subcategory subcategory;

//ovo bi trebala biti neka klasa tipa subcategories_screen_controller
//koja će onda voditi na potreban sreen ovisno što se prikazuje
// -- trenutno samo služi za pregled mjesta odabrane podkategorije

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsyncValue = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(subcategory.title),
      ),
      body: placesAsyncValue.when(
        data: (places) => ListView.builder(
          itemCount: places.length,
          itemBuilder: (context, index) {
            final place = places[index];
            if (place is PlaceWithDetails) {
              //vrati prikaz s karticama i detaljima
              return ListTile(
                tileColor: Colors.amber,
                title: Text(place.title),
                subtitle: Text(place.contactNumber ?? ''),
              );
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => SubcategoriesListItemsScreen(
              //       subcategory: subcategory,
              //     ),
              //   ),
              // );
              //vrati običan prikaz za sve ostale kategorije koje nisu smještaj i gastronomija
            } else {
              return ListTile(
                title: Text(place.title),
              );
            }
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Greška: $error')),
      ),
    );
  }
}
