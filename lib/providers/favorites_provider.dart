import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/utils/place_serialization.dart';

class FavoritePlacesNotifier extends StateNotifier<List<Place>> {
  FavoritePlacesNotifier() : super([]) {
    _loadFavoritePlaces();
  }

  Future<void> _loadFavoritePlaces() async {
    final favorites = await getFavoritePlaces();
    state = favorites;
  }

  Future<void> saveFavoritePlaces(List<Place> favoritePlaces) async {
    final prefs = await SharedPreferences.getInstance();
    final serializedPlaces =
        favoritePlaces.map((place) => serializePlace(place)).toList();
    await prefs.setString('favorite_places', jsonEncode(serializedPlaces));
  }

  Future<List<Place>> getFavoritePlaces() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('favorite_places');

    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => deserializePlace(json)).toList();
  }

  Future<bool> togglePlaceFavoriteStatus(Place place) async {
    final placeIsFavorite = state.any((p) => p.id == place.id);

    if (placeIsFavorite) {
      state = state.where((p) => p.id != place.id).toList();
    } else {
      state = [...state, place];
    }

    await saveFavoritePlaces(state);
    return !placeIsFavorite;
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<Place>>((ref) {
  return FavoritePlacesNotifier();
});
