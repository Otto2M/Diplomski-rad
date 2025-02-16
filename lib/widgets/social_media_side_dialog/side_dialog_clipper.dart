import 'package:flutter/material.dart';

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
