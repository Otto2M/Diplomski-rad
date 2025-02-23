import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/providers/image_storage_provider.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/screens/image_gallery.dart';
import 'package:povedi_me_app/utils/description_lenght_split.dart';
import 'package:povedi_me_app/widgets/custom_app_bar_with_favorite.dart';
import 'package:povedi_me_app/widgets/image_with_error_handling.dart';

class PlaceDetailsCategoryScreen extends ConsumerWidget {
  const PlaceDetailsCategoryScreen({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesAsyncValue = ref.watch(folder1ImagesProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBarWithFavorite(
                  onBack: () {
                    Navigator.pop(context);
                  },
                  place: place,
                ),
                Text(
                  place.title,
                  style: AppTextStyles.placeHeadline2(context),
                ),
                const SizedBox(height: 20),
                buildParagraphs(
                  context,
                  splitTextBySentences(place.description, 4),
                ),
                const SizedBox(height: 20),
                place.imageUrl.isEmpty
                    ? Center(
                        child: Text(
                          "Ova lokacija ne sadrži slike",
                          style: AppTextStyles.description(context),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: place.imageUrl.length, // Broj slika
                        itemBuilder: (context, index) {
                          final imagesUrl = place.imageUrl[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullScreenImageGallery(
                                    imageUrls: place.imageUrl,
                                    initialIndex: index,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: place.imageUrl[index],
                              child: ImageWithErrorHandling(
                                imageUrl: imagesUrl,
                                fit: BoxFit.cover,
                                height: 120,
                                width: 150,
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
