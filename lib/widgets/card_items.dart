import 'package:flutter/material.dart';
import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/screens/subcategories/place_item_details_screen.dart';
import 'package:povedi_me_app/widgets/reviews/rating_star_bar.dart';
import 'package:transparent_image/transparent_image.dart';

class CardItems extends StatelessWidget {
  const CardItems({
    super.key,
    required this.place,
    required this.isInteractive,
  });

  final PlaceWithDetails place;
  final bool isInteractive;

  @override
  Widget build(BuildContext context) {
    final List<String> imagesUrl = place.imageUrl;

    return Card(
      color: Theme.of(context).colorScheme.primary,
      margin: isInteractive
          ? const EdgeInsets.all(20)
          : const EdgeInsets.only(top: 20, left: 3),
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 10,
      child: SizedBox(
        width: 350,
        child: isInteractive
            ? InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PlaceItemDetailsScreen(
                        placeWithDetails: place,
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
                place.title,
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
                child: RatingStarBar(
                  placeWithDetails: place,
                  isCardItemBar: true,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isInteractive
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PlaceItemDetailsScreen(
                                  placeWithDetails: place,
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
