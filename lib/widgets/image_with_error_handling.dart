import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

class ImageWithErrorHandling extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit fit;
  final String errorMessage;
  final bool isEventCard;
  final bool isCard;

  const ImageWithErrorHandling({
    super.key,
    required this.imageUrl,
    this.height = double.infinity,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
    this.errorMessage = 'Slika nije dostupna',
    this.isEventCard = false,
    this.isCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: (isEventCard)
          ? BorderRadius.circular(12.0)
          : (isCard)
              ? BorderRadius.circular(0.0)
              : BorderRadius.circular(8.0),
      child: Image.network(
        imageUrl,
        fit: fit,
        height: height,
        width: width,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: height,
            width: width,
            color: Colors.grey[300],
            child: Center(
              child: Text(
                errorMessage,
                style: AppTextStyles.description(context),
              ),
            ),
          );
        },
      ),
    );
  }
}
