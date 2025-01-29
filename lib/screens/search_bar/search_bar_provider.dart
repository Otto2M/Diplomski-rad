import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/providers/places_provider.dart';

// Provider za praćenje unosa pretraživanja
final searchQueryProvider = StateProvider<String>((ref) => '');

// Provider za filtrirane podatke
final filteredPlacesProvider = Provider<List<dynamic>>((ref) {
  final allPlaces = ref.watch(placesProvider).asData?.value ?? [];
  final query = ref.watch(searchQueryProvider).toLowerCase();

  if (query.isEmpty) return allPlaces;

  // Filtriranje svih tipova koji imaju `title`
  return allPlaces.where((place) {
    if (place is Place || place is PlaceWithDetails || place is ShoppingPlace) {
      return place.title.toLowerCase().startsWith(query);
    }
    return false;
  }).toList();
});
