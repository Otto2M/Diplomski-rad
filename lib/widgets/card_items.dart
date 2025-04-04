import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/screens/google_map/map_screen.dart';
import 'package:povedi_me_app/screens/subcategories/place_item_details_screen.dart';
import 'package:povedi_me_app/services/place_details_service.dart';
import 'package:povedi_me_app/widgets/image_with_error_handling.dart';
import 'package:povedi_me_app/widgets/reviews/rating_star_bar.dart';

class CardItems extends ConsumerStatefulWidget {
  const CardItems({
    super.key,
    required this.place,
    required this.isInteractive,
  });

  final PlaceWithDetails place;
  final bool isInteractive;

  @override
  ConsumerState<CardItems> createState() => _CardItemsState();
}

class _CardItemsState extends ConsumerState<CardItems> {
  @override
  Widget build(BuildContext context) {
    final List<String> imagesUrl = widget.place.imageUrl;

    return Card(
      color: Theme.of(context).colorScheme.primary,
      margin: widget.isInteractive
          ? const EdgeInsets.all(20)
          : const EdgeInsets.only(top: 20, left: 3),
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 10,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 50,
        child: widget.isInteractive
            ? InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PlaceItemDetailsScreen(
                        placeWithDetails: widget.place,
                      ),
                    ),
                  );
                },
                child: _buildCardContent(imagesUrl, context),
              )
            : _buildCardContent(imagesUrl, context),
      ),
    );
  }

  Widget _buildCardContent(List<String> imagesUrl, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth;
        double imageWidth = 160;
        double textWidth = availableWidth - imageWidth - 10;

        return Row(
          children: [
            ImageWithErrorHandling(
              imageUrl: imagesUrl.isNotEmpty ? imagesUrl.first : '',
              fit: BoxFit.cover,
              height: 160,
              width: imageWidth,
              isCard: true,
            ),
            Container(
              width: textWidth,
              height: 155,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.place.title,
                      textAlign: TextAlign.left,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style:
                          AppTextStyles.subcategoryCardPlaceHeadline(context),
                    ),
                    Text(
                      'Recenzije:',
                      style: AppTextStyles.subcategoryDesc(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 20,
                      ),
                      child: Consumer(
                        builder: (context, ref, _) {
                          return FutureBuilder<Map<String, dynamic>>(
                            future: ref
                                .read(placeDetailsServiceProvider)
                                .fetchPlaceDetails(
                                  placeName: widget.place.title,
                                ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text(
                                  'Error: ${snapshot.error}',
                                  style: AppTextStyles.errorText(context),
                                );
                              } else if (snapshot.hasData) {
                                final double rating =
                                    snapshot.data!['rating'] ?? 0.0;
                                return RatingStarBar(
                                  rating: rating,
                                  placeWithDetails: widget.place,
                                  isCardItemBar: true,
                                );
                              } else {
                                return Text(
                                  'Nema podataka za recenziju',
                                  style: AppTextStyles.description(context),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                    widget.isInteractive
                        ? const SizedBox()
                        : DecoratedBox(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSecondary,
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
                                          placeLatitude: widget
                                              .place.coordinates['latitude'],
                                          placeLongitude: widget
                                              .place.coordinates['longitude'],
                                          isFromPlace: true,
                                          place: widget.place,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Image.asset(
                                    Assets.iMap,
                                    height: 22,
                                    width: 22,
                                  )),
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        widget.isInteractive
                            ? ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PlaceItemDetailsScreen(
                                        placeWithDetails: widget.place,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.buttonRed,
                                  minimumSize: const Size(1, 30),
                                  elevation: 10,
                                ),
                                child: Text(
                                  "Više".toUpperCase(),
                                  style: AppTextStyles.cardButtonTitle(context),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
