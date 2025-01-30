import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/providers/bottom_navigation_provider.dart';

class CurvedBottomNavigation extends ConsumerStatefulWidget {
  const CurvedBottomNavigation({super.key});

  @override
  ConsumerState<CurvedBottomNavigation> createState() =>
      _CurvedBottomNavigationState();
}

class _CurvedBottomNavigationState
    extends ConsumerState<CurvedBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);
    return CurvedNavigationBar(
      items: [
        Icon(
          Icons.map,
          color: indexBottomNavbar == 0
              ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
              : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        ),
        Icon(
          Icons.home,
          color: indexBottomNavbar == 1
              ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
              : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        ),
        Icon(
          Icons.favorite,
          color: indexBottomNavbar == 2
              ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
              : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        ),
      ],
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
      color: Theme.of(context).colorScheme.primaryContainer, //primary,
      animationDuration: const Duration(milliseconds: 300),
      height: 65,
      onTap: (index) => ref.read(indexBottomNavbarProvider.notifier).update(
            (state) => index,
          ),
    );
  }
}
