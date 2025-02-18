import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/providers/bottom_navigation_provider.dart';
import 'package:povedi_me_app/providers/favorites_provider.dart';
import 'package:povedi_me_app/screens/home/home_screen.dart';
import 'package:povedi_me_app/screens/favorite_places/favorite_places_screen.dart';
import 'package:povedi_me_app/screens/google_map/map_screen.dart';
import 'package:povedi_me_app/screens/search_bar/search_bar.dart';
import 'package:povedi_me_app/widgets/bottom_navigation/curved_bottom_navigation.dart';
import 'package:povedi_me_app/widgets/menu/app_drawer_menu.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);

    Widget activePage;
    if (indexBottomNavbar == 0) {
      activePage = const MapScreen();
    } else if (indexBottomNavbar == 1) {
      activePage = const HomeScreen();
    } else if (indexBottomNavbar == 2) {
      final favoritePlaces = ref.watch(favoritePlacesProvider);
      activePage = FavoritePlacesTabScreen(
        favoritePlaces: favoritePlaces,
      );
    } else {
      activePage = const HomeScreen();
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 65,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: Icon(
              Icons.menu_rounded,
              size: 40,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            padding: const EdgeInsets.all(12.0),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(top: 6.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: const CustomSearchBar(),
              ),
            ),
          ],
        ),
        body: activePage,
        drawer: const AppDrawer(),
        bottomNavigationBar: const CurvedBottomNavigation(),
      ),
    );
  }
}
