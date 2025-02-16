import 'package:flutter/material.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/widgets/social_media_side_dialog/platform_specific_dialog.dart';
import 'package:povedi_me_app/widgets/social_media_side_dialog/side_dialog_clipper.dart';
import 'package:url_launcher/url_launcher.dart';

class SideDialog extends StatelessWidget {
  const SideDialog({
    super.key,
    required this.isDialogVisible,
    required this.onDismiss,
    required this.place,
  });

  final PlaceWithDetails place;
  final bool isDialogVisible;
  final VoidCallback onDismiss;

  Future<void> _checkAndLaunchURL(
      BuildContext context, String? url, String linkType) async {
    if (url == null || url.isEmpty) {
      final errorMessage = _generateErrorMessage(linkType);
      showErrorDialog(context, errorMessage);
    } else {
      await _launchURL(url);
    }
  }

  String _generateErrorMessage(String linkType) {
    switch (linkType) {
      case 'facebook':
        return 'Mjesto "${place.title}" nema Facebook profil.';
      case 'instagram':
        return 'Mjesto "${place.title}" nema Instagram profil.';
      case 'web':
        return 'Mjesto "${place.title}" ne sadrži poveznicu na web stranicu.';
      default:
        return 'Poveznica nije dostupna.';
    }
  }

  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => PlatformSpecificDialog(errorMessage: errorMessage),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isDialogVisible)
          GestureDetector(
            onTap: onDismiss,
            child: Container(
              color: Colors.black.withOpacity(0.4),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          right: isDialogVisible ? 0 : -300,
          //top: MediaQuery.of(context).size.height * 0.4, // Vertically center
          top: 20,
          bottom: 20,
          child: ClipPath(
            clipper: SideDialogClipper(),
            // child: AnimatedContainer(
            //   duration: const Duration(microseconds: 500),
            //   curve: Curves.easeInOut,
            //   width: MediaQuery.of(context).size.height * 0.12,
            //   height: MediaQuery.of(context).size.height *
            //       0.4, // Not taking full height
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).colorScheme.primaryContainer,
            //     borderRadius: const BorderRadius.only(
            //       topLeft: Radius.circular(50),
            //       bottomLeft: Radius.circular(50),
            //     ),
            //   ),
            child: Container(
              width: 150, // Širina dialoga
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    icon: const Icon(Icons.facebook,
                        size: 50, color: Colors.white),
                    onPressed: () => _checkAndLaunchURL(
                        context, place.facebookProfile, 'facebook'),
                  ),
                  IconButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    icon: const Icon(Icons.camera_alt,
                        size: 50, color: Colors.white),
                    onPressed: () => _checkAndLaunchURL(
                        context, place.instagramProfile, 'instagram'),
                  ),
                  IconButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    icon:
                        const Icon(Icons.public, size: 50, color: Colors.white),
                    onPressed: () =>
                        _checkAndLaunchURL(context, place.webLink, 'web'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
