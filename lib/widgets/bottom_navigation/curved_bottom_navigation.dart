import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';

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
        Image.asset(
          Assets.iMap,
          width: 30,
          height: 30,
          color: indexBottomNavbar == 0
              ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
              : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        ),
        Image.asset(
          Assets.iHome,
          width: 25,
          height: 25,
          color: indexBottomNavbar == 1
              ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
              : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        ),
        Image.asset(
          Assets.iFavorite,
          width: 25,
          height: 25,
          color: indexBottomNavbar == 2
              ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
              : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        ),
      ],
      index: indexBottomNavbar,
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.selectedItemColor ??
              AppColors.white,
      color: Theme.of(context).colorScheme.primaryContainer, //primary,
      animationDuration: const Duration(milliseconds: 300),
      height: 65,
      onTap: (index) => ref.read(indexBottomNavbarProvider.notifier).update(
            (state) => index,
          ),
    );
  }
}
