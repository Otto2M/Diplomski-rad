import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title,
    required this.onBack,
  });

  final String? title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: onBack,
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
          ),
          iconSize: 50,
        ),
        Text(
          title ?? "",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          softWrap: true,
        ),
      ],
    );
  }
}
