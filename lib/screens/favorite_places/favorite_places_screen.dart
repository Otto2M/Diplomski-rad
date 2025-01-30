import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/widgets/favorite_places_list.dart';
import 'package:povedi_me_app/widgets/menu/app_drawer_menu.dart';

class FavoritePlacesTabScreen extends ConsumerWidget {
  const FavoritePlacesTabScreen({
    super.key,
    required this.title,
    required this.favoritePlaces,
  });

  final String title;
  final List<Place> favoritePlaces;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Oh ne...',
            style: AppTextStyles.description(context),
          ),
          const SizedBox(height: 16),
          Text(
            'Još nemate popis omiljenih mjesta.',
            style: AppTextStyles.description(context),
          ),
        ],
      ),
    );

    if (favoritePlaces.isNotEmpty) {
      content = FavoritePlacesList(
        favoritePlaces: favoritePlaces,
        title: title,
      );
    }

    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: content,
      ),
    );
  }
}
