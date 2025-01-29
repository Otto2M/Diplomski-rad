import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/providers/bottom_navigation_provider.dart';
import 'package:povedi_me_app/providers/favorites_provider.dart';
import 'package:povedi_me_app/screens/home/home_screen.dart';
import 'package:povedi_me_app/widgets/bottom_navigation.dart';
import 'package:povedi_me_app/screens/favorite_places/favorite_places_screen.dart';
import 'package:povedi_me_app/screens/google_map/map_screen.dart';
import 'package:povedi_me_app/widgets/menu/app_drawer_menu.dart';

// GlobalKey za Scaffold
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class TabScreen extends ConsumerWidget {
  const TabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);

    Widget activePage = HomeScreen(scaffoldKey: _scaffoldKey);

    if (indexBottomNavbar == 0) {
      activePage = const MapScreen();
    }

    if (indexBottomNavbar == 2) {
      final favoritePlaces = ref.watch(favoritePlacesProvider);
      activePage = FavoritePlacesTabScreen(
        title: 'My Favorites',
        favoritePlaces: favoritePlaces,
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      body: activePage,
      drawer: const AppDrawer(),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
