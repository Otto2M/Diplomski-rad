import 'package:flutter/material.dart';
import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/screens/google_map/map_screen.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () => goToDetailScreen(context, place),
                  label: Text(
                    place.title,
                    style: AppTextStyles.placeButtonTitle(context),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_right_rounded),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MapScreen(
                                placeLatitude: place.coordinates['latitude'],
                                placeLongitude: place.coordinates['longitude'],
                                isFromPlace: true,
                                place: place,
                              ),
                            ),
                          );
                        },
                        icon: Image.asset(
                          Assets.iMap,
                          height: 22,
                          width: 22,
                          color:
                              Theme.of(context).colorScheme.tertiaryContainer,
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              place.description,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.categoryPlaceDescription(context),
            ),
            const SizedBox(height: 20),
            place.imageUrl.isEmpty
                ? Center(
                    child: Text(
                      "Ova lokacija ne sadrži slike",
                      style: AppTextStyles.description(context),
                    ),
                  )
                : SizedBox(
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
