import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/services/language_service.dart';

class LanguageDropdownMenu extends ConsumerWidget {
  const LanguageDropdownMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String selectedLanguage = ref.watch(languageProvider);
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: selectedLanguage,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.lightBlue,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: AppColors.darkBlue, width: 3),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          ),
          items: [
            DropdownMenuItem(
                value: 'hr',
                child: Text(
                  'Hrvatski',
                  style: AppTextStyles.profileSelectedTheme(context),
                )),
            DropdownMenuItem(
                value: 'en',
                child: Text(
                  'English',
                  style: AppTextStyles.profileSelectedTheme(context),
                )),
            DropdownMenuItem(
                value: 'de',
                child: Text(
                  'Deutsch',
                  style: AppTextStyles.profileSelectedTheme(context),
                )),
          ],
          onChanged: (value) {
            if (value != null) {
              ref.read(languageProvider.notifier).setLanguage(value);
            }
          },
        ),
      ],
    );
  }
}
