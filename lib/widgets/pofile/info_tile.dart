import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

class InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const InfoTile({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width * 0.35,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: AppTextStyles.profileGeneralData(context),
            ),
          ),
          const SizedBox(width: 50),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: AppTextStyles.profileSelectedTheme(context),
            ),
          ),
        ],
      ),
    );
  }
}
