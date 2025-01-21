import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/providers/places_provider.dart';

final filteredPlacesBySubcategoriesProvider =
    Provider.family<List<dynamic>, String>((ref, subcategoryId) {
  final placesAsyncValue = ref.watch(placesProvider);

  return placesAsyncValue.when(
    data: (places) {
      return places
          .where((place) => place.subcategoryId == subcategoryId)
          .toList();
    },
    loading: () => [],
    error: (error, stack) => [],
  );
});
