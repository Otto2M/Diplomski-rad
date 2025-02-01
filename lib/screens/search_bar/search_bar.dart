import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/screens/search_bar/search_bar_provider.dart';

class CustomSearchBar extends ConsumerStatefulWidget {
  const CustomSearchBar({super.key});

  @override
  ConsumerState<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends ConsumerState<CustomSearchBar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          ref.read(searchQueryProvider.notifier).state = value;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          hintText: 'Pretraživanje',
          hintStyle: AppTextStyles.drawerMenuStyle(context),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 189, 189, 189),
              width: 2.0,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            borderSide: BorderSide(
              color: Colors.blueAccent,
              width: 2.0,
            ),
          ),
          fillColor: Colors.grey[350],
          filled: true,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
