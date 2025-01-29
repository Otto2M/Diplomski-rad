import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/providers/categories_provider.dart';
import 'package:povedi_me_app/screens/places/places_list_category_screen.dart';
import 'package:povedi_me_app/screens/subcategories/subcategories_screen.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsyncValue = ref.watch(categoriesProvider);
    final subcategoriesAsyncValue = ref.watch(subcategoriesProvider);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Zaglavlje Drawera
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
            ),
            child: const Text(
              'Kategorije',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),

          // Dohvaćanje i prikaz kategorija
          categoriesAsyncValue.when(
            data: (categories) {
              return subcategoriesAsyncValue.when(
                data: (subcategories) {
                  return Column(
                    children: categories.map((category) {
                      // Provjeri ima li podkategorije za ovu kategoriju
                      final hasSubcategories = subcategories.any(
                          (subcategory) =>
                              subcategory.categoryId == category.id);

                      return ListTile(
                        leading:
                            Icon(Icons.category), // Ikona može biti dinamična
                        title: Text(category.title),
                        onTap: () {
                          Navigator.pop(context);

                          if (hasSubcategories) {
                            // Ako kategorija ima podkategorije, otvoriti ekran za podkategorije
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SubcategoriesScreen(
                                  category: category,
                                ),
                              ),
                            );
                          } else {
                            // Inače, otvoriti ekran za listu svih mjesta
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PlacesListCategoryScreen(
                                  title: category.title,
                                  categoryId: category.id,
                                ),
                              ),
                            );
                          }
                        },
                      );
                    }).toList(),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: Text(
                      'Došlo je do greške prilikom učitavanja podkategorija: $error'),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
              child: Text(
                  'Došlo je do greške prilikom učitavanja kategorija: $error'),
            ),
          ),
        ],
      ),
    );
  }
}
