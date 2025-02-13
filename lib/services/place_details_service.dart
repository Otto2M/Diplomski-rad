import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/services/google_places_api.dart';

final placeDetailsServiceProvider = Provider<PlaceDetailsService>((ref) {
  return PlaceDetailsService();
});

class PlaceDetailsService {
  final Map<String, Map<String, dynamic>> _cachedPlaceDetails = {};

  Future<Map<String, dynamic>> fetchPlaceDetails({
    required String placeName,
  }) async {
    if (_cachedPlaceDetails.containsKey(placeName)) {
      return _cachedPlaceDetails[placeName]!;
    }

    final details = await fetchPlaceDetailsFromAPI(
      placeName: placeName,
    );

    // Pohrani podatke za buduće korištenje
    _cachedPlaceDetails[placeName] = details;
    return details;
  }

  Future<Map<String, dynamic>> fetchPlaceDetailsFromAPI({
    required String placeName,
  }) async {
    final placeId = await fetchPlaceIdFromPlaceName(
      placeName: placeName,
    );

    if (placeId != null) {
      final placeDetails = await fetchWorkingHours(
        placeId: placeId,
      );

      return {
        "placeId": placeId,
        "workingHours": placeDetails["workingHours"],
        "openNow": placeDetails["openNow"],
        "rating": placeDetails["rating"],
      };
    } else {
      return {
        "placeId": null,
        "workingHours": null,
        "openNow": false,
        "rating": 0.0,
      };
    }
  }
}
