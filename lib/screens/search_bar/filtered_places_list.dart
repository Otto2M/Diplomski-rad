import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/screens/places/place_details_category_screen.dart';
import 'package:povedi_me_app/screens/places/shopping_places_screen.dart';
import 'package:povedi_me_app/screens/search_bar/search_bar_provider.dart';
import 'package:povedi_me_app/screens/subcategories/place_item_details_screen.dart';

class FilteredPlacesList extends ConsumerWidget {
  const FilteredPlacesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final filteredPlaces = ref.watch(filteredPlacesProvider);

    if (filteredPlaces.isEmpty) {
      return const Center(
        child: Text('Nema rezultata.'),
      );
    }

    if (query.isNotEmpty && filteredPlaces.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6.0),
        padding: const EdgeInsets.all(8.0),
        width: 250,
        decoration: BoxDecoration(
          color: AppColors.darkBlue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredPlaces.length,
          itemBuilder: (context, index) {
            final place = filteredPlaces[index];
            return InkWell(
              onTap: () {
                if (place is PlaceWithDetails) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          PlaceItemDetailsScreen(placeWithDetails: place),
                    ),
                  );
                } else if (place is ShoppingPlace) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShoppingPlacesScreen(
                        place: place,
                        isFiltered: true,
                      ),
                    ),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          PlaceDetailsCategoryScreen(place: place),
                    ),
                  );
                }

                ref.read(searchQueryProvider.notifier).state = '';
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    Text(
                      place.title,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.drawerHeaderProfileTxt(context),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 6),
                    const Divider(
                      color: AppColors.white,
                      indent: 8,
                      endIndent: 8,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    return const SizedBox();
  }
}
