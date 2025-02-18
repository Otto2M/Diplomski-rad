import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/providers/bottom_navigation_provider.dart';

class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);
    return BottomNavigationBar(
      currentIndex: indexBottomNavbar,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            Assets.iMap,
            width: 50,
            height: 50,
            color: indexBottomNavbar == 0
                ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
                : Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
          ),
          label: 'Map',
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            Assets.iHome,
            width: 50,
            height: 50,
            color: indexBottomNavbar == 1
                ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
                : Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
          ),
          label: 'Home',
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            Assets.iFavorite,
            width: 50,
            height: 50,
            color: indexBottomNavbar == 2
                ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
                : Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
          ),
          label: 'Favorite',
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        ),
        // BottomNavigationBarItem(
        //  icon: Icon(
        //     Icons.person,
        //     size: 40,
        //   ),
        //   label: 'My Profile',
        //   backgroundColor: Theme.of(context).colorScheme.primary,
        // ),
      ],
      type: BottomNavigationBarType
          .shifting, //omogućuje izmjenu boje pozadine ovisno o aktivnom indexu (odabranom screenu)
      selectedItemColor: Colors.white,
      //unselectedItemColor: Colors.white,
      selectedFontSize: 14,
      elevation: 16.0,
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      onTap: (value) => ref.read(indexBottomNavbarProvider.notifier).update(
            (state) => value,
          ),
      showSelectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600, // Podebljano za selektirane
        color: Colors.white, // Bijela boja za selektirane
      ),
    );
  }
}
