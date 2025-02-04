import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

class ThemeModeCustom extends ConsumerStatefulWidget {
  const ThemeModeCustom({
    super.key,
    required this.isEditing,
    required this.selectedTheme,
    required this.onThemeChanged,
  });

  final bool isEditing;
  final ThemeMode selectedTheme;
  final ValueChanged<ThemeMode> onThemeChanged;

  @override
  ConsumerState<ThemeModeCustom> createState() => _ThemeModeCustomState();
}

class _ThemeModeCustomState extends ConsumerState<ThemeModeCustom> {
  late ThemeMode tempSelectedTheme;

  @override
  void initState() {
    super.initState();
    tempSelectedTheme = widget.selectedTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isEditing) ...[
            Text(
              'Odaberite temu aplikacije:',
              style: AppTextStyles.profileSelectedThemeHeadline(context),
            ),
            _buildRadioOption(
              title: 'Automatic',
              value: ThemeMode.system,
            ),
            _buildRadioOption(
              title: 'Light Mode',
              value: ThemeMode.light,
            ),
            _buildRadioOption(
              title: 'Dark Mode',
              value: ThemeMode.dark,
            ),
          ] else ...[
            Text(
              'Odabrana tema:',
              style: AppTextStyles.profileSelectedThemeHeadline(context),
            ),
            const SizedBox(height: 16),
            _buildRadioOption(
              title: 'Automatic',
              value: ThemeMode.system,
              isDisabled: true,
            ),
            _buildRadioOption(
              title: 'Light Mode',
              value: ThemeMode.light,
              isDisabled: true,
            ),
            _buildRadioOption(
              title: 'Dark Mode',
              value: ThemeMode.dark,
              isDisabled: true,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRadioOption({
    required String title,
    required ThemeMode value,
    bool isDisabled = false,
  }) {
    return ListTile(
      dense: true,
      minTileHeight: 6,
      minVerticalPadding: 6,
      title: Text(
        title,
        style: AppTextStyles.profileSelectedTheme(context),
      ),
      leading: Radio<ThemeMode>(
        value: value,
        groupValue: tempSelectedTheme,
        // activeColor: Theme.of(context).colorScheme.primaryContainer,
        onChanged: isDisabled
            ? null
            : (value) {
                if (value != null) {
                  setState(() {
                    tempSelectedTheme = value;
                  });
                  widget.onThemeChanged(value);
                }
              },
      ),
    );
  }
}
