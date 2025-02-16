import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

class PlatformSpecificDialog extends StatelessWidget {
  const PlatformSpecificDialog({
    super.key,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.orange, size: 28),
            SizedBox(width: 10),
            Text('Obavijest'),
          ],
        ),
        content: Text(
          errorMessage,
          style: AppTextStyles.profileAlertBoxDescription(context),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'U redu',
              style: AppTextStyles.profileAlertBoxButtons(context),
            ),
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.orange, size: 28),
            SizedBox(width: 10),
            Text('Obavijest'),
          ],
        ),
        content: Text(
          errorMessage,
          style: AppTextStyles.profileAlertBoxDescription(context),
        ),
        actions: [
          const Divider(
            color: AppColors.darkBlue,
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'U redu',
              style: AppTextStyles.profileAlertBoxButtons(context),
            ),
          ),
        ],
      );
    }
  }
}
