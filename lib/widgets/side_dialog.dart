import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SideDialog extends StatelessWidget {
  const SideDialog({
    super.key,
    required this.isDialogVisible,
    required this.onDismiss,
  });

  final bool isDialogVisible;
  final VoidCallback onDismiss;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
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
                      horizontal: 20,
                      vertical: 10,
                    ),
                    icon: Icon(Icons.facebook, size: 50, color: Colors.white),
                    onPressed: () => _launchURL('https://www.facebook.com'),
                  ),
                  IconButton(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    icon: const Icon(Icons.camera_alt,
                        size: 50, color: Colors.white),
                    onPressed: () => _launchURL(
                        'https://podravka-ugostiteljstvo.hr/pivnica-kralus/'),
                  ),
                  IconButton(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    icon: Icon(Icons.public, size: 50, color: Colors.white),
                    onPressed: () => _launchURL('https://www.google.com'),
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

class SideDialogClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(size.width, 0);

    // Gornja zakrivljenost prema sredini
    path.quadraticBezierTo(
      size.width * 0.95, // !
      size.height * 0.2, // -
      size.width * 0.3, // +
      size.height * 0.4, // ?
    );

    // // Zaobljeni prijelaz u ravni dio
    // path.arcToPoint(
    //   Offset(
    //     size.width * 0.6,
    //     size.height * 0.6,
    //   ), // Krajnja točka luka
    //   radius: const Radius.circular(30.0), // Polumjer za zaobljenje
    //   clockwise: false, // Smjer
    // );

    // Srednji ravni dio
    path.lineTo(
      size.width * 0.3, // +
      size.height * 0.6, // ?
    );

    // Donja zakrivljenost prema desnom donjem kutu
    path.quadraticBezierTo(
      size.width * 0.95, // !
      size.height * 0.8, // -
      size.width,
      size.height,
    );

    path.lineTo(size.width, 0);

    // // Zatvaranje puta
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
