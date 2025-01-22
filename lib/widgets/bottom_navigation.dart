import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/providers/bottom_navigation_provider.dart';

class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);
    return BottomNavigationBar(
      currentIndex: indexBottomNavbar,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
            ),
            label: 'Map',
            backgroundColor: Colors.green),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
            backgroundColor: Colors.blue),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Favorite',
            backgroundColor: Colors.amber),
      ],
      type: BottomNavigationBarType
          .shifting, //omogućuje izmjenu boje pozadine ovisno o aktivnom indexu (odabranom screenu)
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.yellow,
      //selectedFontSize: 14,
      elevation: 16.0,
      iconSize: 40,
      backgroundColor:
          Colors.blue, // Boja pozadine trake (ako se ne koristi `shifting`).
      onTap: (value) => ref.read(indexBottomNavbarProvider.notifier).update(
            (state) => value,
          ),
    );
  }
}
