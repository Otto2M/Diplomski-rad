import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required this.imagesUrl,
  });

  final List<String> imagesUrl;

  List<Image> convertToNetworkImage(List<String> imagesUrl) {
    return imagesUrl.map((imageUrl) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: Center(
              child: Text(
                "Slika nije dostupna",
                style: AppTextStyles.description(context),
              ),
            ),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CarouselSlider(
      items: convertToNetworkImage(imagesUrl),
      options: CarouselOptions(
        height: size.height * 0.3,
        enlargeCenterPage: true,
        autoPlay: true,
        enableInfiniteScroll: true,
        viewportFraction: 1,
      ),
    );
  }
}
