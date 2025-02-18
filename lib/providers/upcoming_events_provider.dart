import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/providers/categories_provider.dart';
import 'package:povedi_me_app/providers/places_provider.dart';
import 'package:povedi_me_app/services/language_service.dart';
import 'package:povedi_me_app/utils/manifestation_translation.dart';

final upcomingEventsProvider = FutureProvider<List<dynamic>>((ref) async {
  // Dohvati sve kategorije
  final categories = await ref.watch(categoriesProvider.future);
  final language = await LanguageService().getLanguage();
  final translatedManifestationTitle =
      getTranslatedManifestationTitle(language).toLowerCase();

  // Nađi ID kategorije "manifestacije"
  final manifestationCategory = categories.firstWhere(
    (category) {
      final categoryTitle = category.title.toLowerCase();
      return categoryTitle == translatedManifestationTitle;
    },
    orElse: () => throw Exception('Kategorija "manifestacije" nije pronađena.'),
  );

  // Dohvati sva mjesta
  final places = await ref.watch(placesProvider.future);

  // Filtriraj mjesta prema ID-u kategorije "manifestacije" i sortiraj silazno prema datumu
  final upcomingEvents = places
      .where((place) => place.categoryId == manifestationCategory.id)
      .toList();

  return upcomingEvents;
});
