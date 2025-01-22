import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/models/category.dart';
import 'package:povedi_me_app/providers/filer_places_provider.dart';
import 'package:povedi_me_app/providers/filter_subcategories_provider.dart';
import 'package:povedi_me_app/screens/subcategories/subcategories_list_items_screen.dart';
import 'package:povedi_me_app/widgets/bottom_navigation.dart';
import 'package:povedi_me_app/widgets/card_items.dart';

class SubcategoriesScreen extends ConsumerWidget {
  const SubcategoriesScreen({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredSubcategories =
        ref.watch(filteredSubcategoriesProvider(category.id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('subactegories'),
      ),
      bottomNavigationBar: BottomNavigation(),
      body: filteredSubcategories.isEmpty
          ? const Center(child: Text('Nema podkategorija za ovu kategoriju'))
          : ListView.builder(
              itemCount: filteredSubcategories.length,
              itemBuilder: (context, index) {
                final subcategory = filteredSubcategories[index];

                // Filtriraj mjesta prema subcategoryId
                final filteredPlaces = ref.watch(
                    filteredPlacesBySubcategoriesProvider(subcategory.id));

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  SubcategoriesListItemsScreen(
                                subcategory: subcategory,
                              ),
                            ),
                          );
                        },
                        child: Text(subcategory.title),
                      ),
                      const SizedBox(height: 30),
                      // Prikaz filtriranih mjesta za tu podkategoriju
                      ...filteredPlaces.map(
                        (place) {
                          return CardItems(
                            place: place,
                            isInteractive: false,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
