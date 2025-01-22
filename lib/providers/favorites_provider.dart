import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/models/place.dart';

class FavoritePlacesNotifier extends StateNotifier<List<Place>> {
  FavoritePlacesNotifier() : super([]);

  bool togglePlaceFavoriteStatus(Place place) {
    final placeIsFavorite = state.contains(place);

    if (placeIsFavorite) {
      state = state.where((p) => p.id != place.id).toList();
      return false;
    } else {
      state = [...state, place];
      return true;
    }
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<Place>>((ref) {
  return FavoritePlacesNotifier();
});
