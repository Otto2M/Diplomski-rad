import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required this.imagesUrl,
  });

  final List<String> imagesUrl;

  List<Image> convertToNetworkImage(List<String> imagesUrl) {
    final List<Image> images = [];
    for (var imageUrl in imagesUrl) {
      final image = Image.network(imageUrl);
      images.add(image);
    }
    return images;
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
