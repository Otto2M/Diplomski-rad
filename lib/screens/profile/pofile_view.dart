import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/constants/firestore_collections.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/models/user.dart';
import 'package:povedi_me_app/providers/theme_mode_option_provider.dart';
import 'package:povedi_me_app/providers/user_provider.dart';
import 'package:povedi_me_app/widgets/pofile/info_tile.dart';
import 'package:povedi_me_app/widgets/user_image_picker.dart';
import 'package:povedi_me_app/widgets/theme_mode_option.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({
    super.key,
    required this.user,
  });

  final User user;

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  bool isEditing = false;
  bool isUpdating = false;
  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController phoneNumberController;
  late String initialName;
  late String initialUsername;
  late String initialPhoneNumber;
  late ThemeMode lastThemeMode;
  File? _selectedImage;
  late File? initialImage;
  late ThemeMode tempSelectedTheme;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    usernameController = TextEditingController(text: widget.user.username);
    phoneNumberController =
        TextEditingController(text: widget.user.phoneNumber);
    tempSelectedTheme = ref.read(themeProvider);

    initialName = widget.user.name;
    initialUsername = widget.user.username;
    initialPhoneNumber = widget.user.phoneNumber;
    lastThemeMode = tempSelectedTheme;

    // Spremi početnu sliku prije uređivanja
    initialImage =
        widget.user.imageUrl != null ? File(widget.user.imageUrl!) : null;
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void cancelEditing() {
    setState(() {
      nameController.text = initialName;
      usernameController.text = initialUsername;
      phoneNumberController.text = initialPhoneNumber;
      tempSelectedTheme = lastThemeMode;
      _selectedImage = initialImage;
      isEditing = false;
    });
  }

  void updateProfile() async {
    setState(() {
      initialName = nameController.text;
      initialUsername = usernameController.text;
      initialPhoneNumber = phoneNumberController.text;
      lastThemeMode = tempSelectedTheme;
      isUpdating = true;
    });

    String imageUrl = widget.user.imageUrl!;

    if (_selectedImage != null) {
      try {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child(FirestoreCollections.userImagesCollection)
            .child('${widget.user.id}.jpg');

        await storageRef.putFile(_selectedImage!);
        imageUrl = await storageRef.getDownloadURL();
      } catch (error) {
        //print('Greška pri spremanju podataka: $error');
        setState(() {
          isUpdating = false;
        });
        return;
      }
    }

    try {
      final updatedUser = User(
        id: widget.user.id,
        name: nameController.text,
        username: usernameController.text,
        email: widget.user.email,
        phoneNumber: phoneNumberController.text,
        imageUrl: imageUrl,
        createdAt: widget.user.createdAt,
        reviews: widget.user.reviews,
      );
      final authService = ref.read(authServiceProvider);
      await authService.updateUserProfile(widget.user.id, updatedUser);

      final themeNotifier = ref.read(themeProvider.notifier);
      await themeNotifier.setThemeMode(tempSelectedTheme);

      ref.refresh(userProvider);
    } catch (error) {
      debugPrint('Greška pri ažuriranju profila: $error');
      setState(() {
        isUpdating = false;
      });
      return;
    }

    setState(() {
      isEditing = false;
      isUpdating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            "Moj profil".toUpperCase(),
            style: AppTextStyles.categoryHeadline(context),
          ),
          const SizedBox(height: 20),
          const Divider(thickness: 2.0),
          const SizedBox(height: 20),
          UserImagePicker(
            isEditing: isEditing,
            imageUrl: widget.user.imageUrl!,
            onPickImage: (pickedImage) {
              _selectedImage = pickedImage;
            },
          ),
          const SizedBox(height: 16),
          if (isEditing) ...[
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Ime i prezime',
                labelStyle: AppTextStyles.description(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.darkBlue),
                ),
              ),
              style: AppTextStyles.description(context),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Korisničko ime',
                labelStyle: AppTextStyles.description(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.darkBlue),
                ),
              ),
              style: AppTextStyles.description(context),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Broj mobitela',
                labelStyle: AppTextStyles.description(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.darkBlue),
                ),
              ),
              style: AppTextStyles.description(context),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            ThemeModeCustom(
              isEditing: isEditing,
              selectedTheme: tempSelectedTheme,
              onThemeChanged: (newTheme) {
                tempSelectedTheme = newTheme;
              },
            ),
            const SizedBox(height: 16),
            if (isUpdating) const CircularProgressIndicator(),
            if (!isUpdating)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                    ),
                    onPressed: updateProfile,
                    child: Text(
                      'Spremi',
                      style: AppTextStyles.profileSaveCancleButtons(context),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: cancelEditing,
                    child: Text(
                      'Odustani',
                      style: AppTextStyles.profileSaveCancleButtons(context),
                    ),
                  ),
                ],
              ),
          ] else ...[
            InfoTile(label: 'Ime i prezime', value: widget.user.name),
            InfoTile(label: 'Korisničko ime', value: widget.user.username),
            InfoTile(label: 'Broj mobitela', value: widget.user.phoneNumber),
            const SizedBox(height: 16),
            ThemeModeCustom(
              isEditing: isEditing,
              selectedTheme: tempSelectedTheme,
              onThemeChanged: (_) {},
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonRed,
                elevation: 10,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
              ),
              child: Text(
                'Uredi profil',
                style: AppTextStyles.subcategoryButtonTitle(context),
              ),
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
            ),
          ],
        ],
      ),
    );
  }
}
