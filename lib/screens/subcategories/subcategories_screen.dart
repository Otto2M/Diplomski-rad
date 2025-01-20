import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/models/category.dart';
import 'package:povedi_me_app/providers/categories_provider.dart';
import 'package:povedi_me_app/screens/subcategories/subcategories_list_items_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class SubcategoriesScreen extends ConsumerWidget {
  const SubcategoriesScreen({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subcategoriesAsyncValue = ref.watch(subcategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('subactegories'),
      ),
      body: subcategoriesAsyncValue.when(
        data: (subcategories) {
          final filteredSubcategories = subcategories
              .where((subcategories) => subcategories.categoryId == category.id)
              .toList();

          return Column(
            children: [
              ...filteredSubcategories.map(
                (filteredSubcategories) {
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
                                  subcategory: filteredSubcategories,
                                ),
                              ),
                            );
                          },
                          child: Text(filteredSubcategories.title),
                        ),
                        const SizedBox(height: 30),
                        Card(
                          color: Colors.blueGrey,
                          margin: const EdgeInsets.all(20),
                          shape: const BeveledRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          elevation: 5,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  FadeInImage(
                                    placeholder: MemoryImage(kTransparentImage),
                                    image: const AssetImage(
                                        'assets/images/povedi_me_logo.png'),
                                    fit: BoxFit.cover,
                                    height: 150,
                                    width: 150,
                                  ),
                                  Container(
                                    color: Colors.black54,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30, horizontal: 30),
                                    child: const Column(
                                      children: [
                                        Text(
                                          'place.title,',
                                          maxLines: 2,
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                        const Text('Recenzija'),
                                        //const PlaceItemInfoReview(icon: Icons.star),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Došlo je do greške: $error'),
        ),
      ),
    );
  }
}
