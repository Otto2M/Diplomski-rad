import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/models/place.dart';

class RatingStarBar extends StatefulWidget {
  const RatingStarBar({
    super.key,
    required this.placeWithDetails,
    required this.isCardItemBar,
  });

  final PlaceWithDetails placeWithDetails;
  final bool isCardItemBar;

  @override
  State<RatingStarBar> createState() => _RatingStarBarState();
}

class _RatingStarBarState extends State<RatingStarBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!widget.isCardItemBar)
          Text(
            "Prosječna ocjena:",
            style: AppTextStyles.subcategoryPlaceDetailsStyle(context),
          ),
        if (!widget.isCardItemBar) const SizedBox(width: 10),
        RatingBar(
          initialRating: widget.placeWithDetails.averageRating ?? 0.0,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: MediaQuery.of(context).devicePixelRatio * 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
          ignoreGestures: true,
          ratingWidget: RatingWidget(
            full: Image.asset(Assets.iStar),
            half: Image.asset(Assets.iStarHalf),
            empty: Image.asset(Assets.iStarRounded),
          ),
          onRatingUpdate: (rating) {},
        ),
        const SizedBox(width: 10),
        if (!widget.isCardItemBar)
          Text(
            widget.placeWithDetails.averageRating != null
                ? "${widget.placeWithDetails.averageRating!.toStringAsFixed(1)} / 5"
                : "Podatak nedostupan",
            style: AppTextStyles.subcategoryPlaceDetailsStyle(context),
          ),
      ],
    );
  }
}
