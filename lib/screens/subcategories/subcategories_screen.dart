import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/models/category.dart';
import 'package:povedi_me_app/providers/filer_places_provider.dart';
import 'package:povedi_me_app/providers/filter_subcategories_provider.dart';
import 'package:povedi_me_app/screens/subcategories/subcategories_list_items_screen.dart';
//import 'package:povedi_me_app/widgets/bottom_navigation.dart';
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
          title: Text(category.title),
        ),
        //bottomNavigationBar: BottomNavigation(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 30,
                left: 20,
                bottom: 10,
                right: 20,
              ),
              child: Text(
                category.title.toUpperCase(),
              ),
            ),
            Expanded(
              child: filteredSubcategories.isEmpty
                  ? const Center(
                      child: Text('Nema podkategorija za ovu kategoriju'))
                  : ListView.builder(
                      itemCount: filteredSubcategories.length,
                      itemBuilder: (context, index) {
                        final subcategory = filteredSubcategories[index];

                        // Filtriraj mjesta prema subcategoryId
                        final filteredPlaces = ref.watch(
                            filteredPlacesBySubcategoriesProvider(
                                subcategory.id));

                        return SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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

                                // Prikaz filtriranih mjesta za tu podkategoriju
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: filteredPlaces.map(
                                      (place) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right:
                                                  10.0), // Razmak između kartica
                                          child: CardItems(
                                            place: place,
                                            isInteractive: false,
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ));
  }
}
