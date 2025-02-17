import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/screens/places/place_details_category_screen.dart';
import 'package:povedi_me_app/widgets/image_with_error_handling.dart';

class PlacesByCategory extends StatelessWidget {
  const PlacesByCategory({
    super.key,
    required this.place,
  });

  final Place place;

  void goToDetailScreen(BuildContext context, Place place) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlaceDetailsCategoryScreen(
          place: place,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () => goToDetailScreen(context, place),
              label: Text(
                place.title,
                style: AppTextStyles.placeButtonTitle(context),
              ),
              icon: const Icon(Icons.keyboard_arrow_right_rounded),
            ),
            const SizedBox(height: 10),
            Text(
              place.description,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.categoryPlaceDescription(context),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: place.imageUrl.length,
                itemBuilder: (context, index) {
                  final imagesUrl = place.imageUrl[index];
                  return Padding(
                      padding: const EdgeInsets.only(
                          right: 10), // Razmak između slika
                      child: ImageWithErrorHandling(
                        imageUrl: imagesUrl,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
