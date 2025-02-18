import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/models/category.dart';
// import 'package:povedi_me_app/providers/categories_notifier.dart';
import 'package:povedi_me_app/screens/places/places_list_category_screen.dart';
import 'package:povedi_me_app/screens/subcategories/subcategories_screen.dart';

class CustomHamburgerMenu extends ConsumerWidget {
  const CustomHamburgerMenu({super.key});

  void showCustomMenu(
      BuildContext context, WidgetRef ref, dynamic categoriesNotifierState) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              overlayEntry.remove();
            },
            child: Container(
              color: Colors.black.withOpacity(0.5), // Poluprozirna pozadina
            ),
          ),
          Positioned(
            top: 100,
            left: 16,
            right: 16,
            child: Material(
              elevation: 60,
              borderRadius: BorderRadius.circular(25),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(25),
                ),
                width: MediaQuery.of(context).size.width * 0.4,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                  //maxWidth: MediaQuery.of(context).size.width * 0.4,
                ),
                child: _buildMenuContent(
                    context, ref, overlayEntry, categoriesNotifierState),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(overlayEntry);
  }

  Widget _buildMenuContent(BuildContext context, WidgetRef ref,
      OverlayEntry overlayEntry, dynamic categoriesNotifierState) {
    //final categoriesNotifierState = ref.watch(categoriesNotifierProvider);

    final List<Category> categories =
        categoriesNotifierState['categories']?.cast<Category>() ?? [];
    final subcategories =
        categoriesNotifierState['subcategories'] as List<Subcategory>;

    if (categories.isEmpty) {
      return const Center(
        child: Text(
          'Nema dostupnih kategorija',
        ),
      );
    }

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final hasSubcategories = subcategories
            .any((subcategory) => subcategory.categoryId == category.id);

        return Column(
          children: [
            ListTile(
              dense: true,
              leading: const Icon(Icons.category, color: Colors.white),
              title: Text(
                category.title,
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                overlayEntry.remove(); // Zatvori meni
                if (hasSubcategories) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SubcategoriesScreen(
                        category: category,
                      ),
                    ),
                  );
                } else {
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
            ),
            const Divider(color: Colors.white),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final categoriesNotifierState = ref.watch(categoriesNotifierProvider);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(icon: const Icon(Icons.menu, size: 40), onPressed: () => {}
            // showCustomMenu(context, ref, categoriesNotifierState),
            ),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context, WidgetRef ref) {
  //   final categoriesAsyncValue = ref.watch(categoriesProvider);
  //   final subcategoriesAsyncValue = ref.watch(subcategoriesProvider);

  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       IconButton(
  //         icon: const Icon(
  //           Icons.menu,
  //           size: 40,
  //         ),
  //         onPressed: () {
  //           Stack(
  //             children: [
  //               Positioned(
  //                 top: 70,
  //                 left: 16,
  //                 right: 16,
  //                 child: Container(
  //                   color: Colors.amber,
  //                   padding: EdgeInsets.all(16),
  //                   alignment: Alignment.topLeft,
  //                   child: Material(
  //                     elevation: 60,
  //                     borderRadius: BorderRadius.circular(25),
  //                     child: Container(
  //                       padding: const EdgeInsets.all(16),
  //                       decoration: BoxDecoration(
  //                         color: Colors.blue.shade900,
  //                         borderRadius: BorderRadius.circular(25),
  //                       ),
  //                       constraints: BoxConstraints(
  //                         maxHeight: MediaQuery.of(context).size.height *
  //                             0.6, // Ograničenje visine
  //                         maxWidth: MediaQuery.of(context).size.width *
  //                             0.8, // Ograničenje širine
  //                       ),
  //                       child: ListView(
  //                         children: [
  //                           // Dohvaćanje i prikaz kategorija
  //                           categoriesAsyncValue.when(
  //                             data: (categories) {
  //                               return subcategoriesAsyncValue.when(
  //                                 data: (subcategories) {
  //                                   return Column(
  //                                     children: categories.map((category) {
  //                                       // Provjeri ima li podkategorije za ovu kategoriju
  //                                       final hasSubcategories =
  //                                           subcategories.any((subcategory) =>
  //                                               subcategory.categoryId ==
  //                                               category.id);

  //                                       return Column(
  //                                         children: [
  //                                           ListTile(
  //                                             leading: Icon(Icons.category,
  //                                                 color: Colors
  //                                                     .white), // Ikona može biti dinamična
  //                                             title: Text(
  //                                               category.title,
  //                                               style: TextStyle(
  //                                                   color: Colors.white),
  //                                             ),
  //                                             onTap: () {
  //                                               Navigator.pop(
  //                                                   context); // Zatvori menu

  //                                               if (hasSubcategories) {
  //                                                 // Ako kategorija ima podkategorije, otvoriti ekran za podkategorije
  //                                                 Navigator.of(context).push(
  //                                                   MaterialPageRoute(
  //                                                     builder: (context) =>
  //                                                         SubcategoriesScreen(
  //                                                       category: category,
  //                                                     ),
  //                                                   ),
  //                                                 );
  //                                               } else {
  //                                                 // Inače, otvoriti ekran za listu svih mjesta
  //                                                 Navigator.of(context).push(
  //                                                   MaterialPageRoute(
  //                                                     builder: (context) =>
  //                                                         PlacesListCategoryScreen(
  //                                                       title: category.title,
  //                                                       categoryId: category.id,
  //                                                     ),
  //                                                   ),
  //                                                 );
  //                                               }
  //                                             },
  //                                           ),
  //                                           Divider(
  //                                               color: Colors
  //                                                   .white), // Linija između kategorija
  //                                         ],
  //                                       );
  //                                     }).toList(),
  //                                   );
  //                                 },
  //                                 loading: () => const Center(
  //                                     child: CircularProgressIndicator()),
  //                                 error: (error, stackTrace) => Center(
  //                                   child: Text(
  //                                       'Došlo je do greške prilikom učitavanja podkategorija: $error',
  //                                       style: TextStyle(color: Colors.white)),
  //                                 ),
  //                               );
  //                             },
  //                             loading: () => const Center(
  //                                 child: CircularProgressIndicator()),
  //                             error: (error, stackTrace) => Center(
  //                               child: Text(
  //                                   'Došlo je do greške prilikom učitavanja kategorija: $error',
  //                                   style: TextStyle(color: Colors.white)),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }
}
