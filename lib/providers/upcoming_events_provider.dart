import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/providers/categories_provider.dart';
import 'package:povedi_me_app/providers/places_provider.dart';

final upcomingEventsProvider = FutureProvider<List<dynamic>>((ref) async {
  // Dohvati sve kategorije
  final categories = await ref.watch(categoriesProvider.future);

  // Nađi ID kategorije "manifestacije"
  final manifestationCategory = categories.firstWhere(
    (category) => category.title.toLowerCase() == 'manifestacije',
    orElse: () => throw Exception('Kategorija "manifestacije" nije pronađena.'),
  );

  // Dohvati sva mjesta
  final places = await ref.watch(placesProvider.future);

  // Filtriraj mjesta prema ID-u kategorije "manifestacije" i sortiraj silazno prema datumu
  final upcomingEvents = places
      .where((place) => place.categoryId == manifestationCategory.id)
      .toList()
    ..sort((a, b) => b.date!.compareTo(a.date!)); // Silazno sortiranje

  return upcomingEvents;
});
