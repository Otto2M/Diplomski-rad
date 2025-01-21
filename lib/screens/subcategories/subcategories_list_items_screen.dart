import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/models/category.dart';
import 'package:povedi_me_app/providers/filer_places_provider.dart';
import 'package:povedi_me_app/widgets/card_items.dart';

class SubcategoriesListItemsScreen extends ConsumerWidget {
  const SubcategoriesListItemsScreen({
    super.key,
    required this.subcategory,
  });

  final Subcategory subcategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredPlacesBySubcategories =
        ref.watch(filteredPlacesBySubcategoriesProvider(subcategory.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(subcategory.title),
      ),
      body: filteredPlacesBySubcategories.isEmpty
          ? const Center(child: Text('Nema mjesta za ovu podkategoriju.'))
          : ListView.builder(
              itemCount: filteredPlacesBySubcategories.length,
              itemBuilder: (context, index) {
                final place = filteredPlacesBySubcategories[index];

                //vrati prikaz s karticama i detaljima
                return CardItems(
                  place: place,
                  isInteractive: true,
                );
              },
            ),
    );
  }
}
