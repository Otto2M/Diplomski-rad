import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    super.key,
    required this.isEditing,
    required this.imageUrl,
    required this.onPickImage,
  });

  final bool isEditing;
  final String imageUrl;
  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedSource = await showDialog<ImageSource>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Odaberi izvor slike",
          style: AppTextStyles.description(context),
        ),
        content: Text(
          "Odaberite želite li snimiti novu sliku ili odabrati iz galerije.",
          style: AppTextStyles.description(context),
        ),
        actionsPadding: const EdgeInsets.all(12),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(ImageSource.camera);
                  },
                  child: Text(
                    "Kamera",
                    style: AppTextStyles.description(context),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(ImageSource.gallery);
                  },
                  child: Text(
                    "Galerija",
                    style: AppTextStyles.description(context),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (pickedSource == null) {
      return;
    }

    final pickedImage = await ImagePicker().pickImage(
      source: pickedSource,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundImage: _pickedImageFile != null
              ? FileImage(_pickedImageFile!)
              : NetworkImage(widget.imageUrl),
        ),
        widget.isEditing
            ? TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image, size: 20),
                label: Text(
                  "Izmjeni sliku",
                  style: AppTextStyles.description(context),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
