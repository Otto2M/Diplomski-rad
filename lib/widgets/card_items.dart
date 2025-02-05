import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/screens/subcategories/place_item_details_screen.dart';
import 'package:povedi_me_app/services/place_details_service.dart';
import 'package:povedi_me_app/widgets/reviews/rating_star_bar.dart';
import 'package:transparent_image/transparent_image.dart';

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
        width: 350,
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
    return Row(
      children: [
        FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: NetworkImage(
            imagesUrl.isNotEmpty ? imagesUrl.first : '',
          ),
          fit: BoxFit.cover,
          height: 160,
          width: 160,
        ),
        Container(
          width: 190,
          height: 160,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.place.title,
                maxLines: 2,
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.subcategoryCardPlaceHeadline(context),
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
                            apiKey: 'AIzaSyBE1s72xyeMR07GgEuz_TsGDX-a58KS-tY',
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
                          final rating = snapshot.data!['rating'] ?? 0.0;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.isInteractive
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PlaceItemDetailsScreen(
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
      ],
    );
  }
}
