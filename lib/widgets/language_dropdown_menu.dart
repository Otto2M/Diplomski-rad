import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/services/language_service.dart';

class LanguageDropdownMenu extends ConsumerWidget {
  const LanguageDropdownMenu({super.key});

  Widget _getDropdown(
      String selectedLanguage, BuildContext context, WidgetRef ref) {
    if (Platform.isIOS) {
      return _buildCupertinoPicker(selectedLanguage, context, ref);
    } else {
      return _buildMaterialDropdown(selectedLanguage, context, ref);
    }
  }

  Widget _buildCupertinoPicker(
      String selectedLanguage, BuildContext context, WidgetRef ref) {
    int initialItem = selectedLanguage == 'hr'
        ? 0
        : selectedLanguage == 'en'
            ? 1
            : 2;

    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: initialItem),
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        String language = index == 0
            ? 'hr'
            : index == 1
                ? 'en'
                : 'de';
        ref.read(languageProvider.notifier).setLanguage(language);
      },
      children: const [
        Text('Hrvatski'),
        Text('English'),
        Text('Deutsch'),
      ],
    );
  }

  Widget _buildMaterialDropdown(
      String selectedLanguage, BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 200,
      child: DropdownButtonFormField<String>(
        value: selectedLanguage,
        dropdownColor: Theme.of(context).colorScheme.secondary,
        decoration: _inputDecoration(context),
        items: _buildDropdownItems(context),
        onChanged: (value) {
          if (value != null) {
            ref.read(languageProvider.notifier).setLanguage(value);
          }
        },
      ),
    );
  }

  InputDecoration _inputDecoration(BuildContext context) {
    return InputDecoration(
      filled: true,
      fillColor: Theme.of(context).colorScheme.secondary,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: AppColors.darkBlue, width: 3),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems(BuildContext context) {
    return [
      _buildDropdownMenuItem('hr', 'Hrvatski', context),
      _buildDropdownMenuItem('en', 'English', context),
      _buildDropdownMenuItem('de', 'Deutsch', context),
    ];
  }

  DropdownMenuItem<String> _buildDropdownMenuItem(
      String value, String label, BuildContext context) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        label,
        style: AppTextStyles.profileGeneralData(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String selectedLanguage = ref.watch(languageProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Jezik:',
              style: AppTextStyles.profileSelectedThemeHeadline(context),
            ),
          ),
          const SizedBox(height: 12.0),
          Center(
            child: _getDropdown(selectedLanguage, context, ref),
          ),
        ],
      ),
    );
  }
}
