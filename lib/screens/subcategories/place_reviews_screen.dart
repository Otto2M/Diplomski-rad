import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/services/cloud_firestore_service.dart';
import 'package:povedi_me_app/widgets/custom_app_bar.dart';

class PlaceReviewsScreen extends StatefulWidget {
  const PlaceReviewsScreen({
    super.key,
    required this.placeWithDetails,
    required this.userId,
  });

  final PlaceWithDetails placeWithDetails;
  final String userId;

  @override
  State<PlaceReviewsScreen> createState() => _PlaceReviewsScreenState();
}

class _PlaceReviewsScreenState extends State<PlaceReviewsScreen> {
  double rating = 0;
  bool isReviewMode = true;

  void saveReview() async {
    final placeId = widget.placeWithDetails.id;

    try {
      await FirestoreDatabaseService().saveReview(
        userId: widget.userId,
        placeId: placeId,
        rating: rating,
      );

      setState(() {
        isReviewMode = false;
      });

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context, true);
      });
    } catch (e) {
      print('Greška pri spremanju recenzije: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(), //kreirati custom app bar
      body: SafeArea(
        child: Stack(
          children: [
            if (isReviewMode)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CustomAppBar(
                  onBack: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isReviewMode) ...[
                    Text(
                      "Vaša ocjena:",
                      style: AppTextStyles.reviewStatusText(context),
                    ),
                    Text(
                      "$rating",
                      style: AppTextStyles.reviewStatusStar(context),
                    ),
                    const SizedBox(height: 30),
                    RatingBar(
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: MediaQuery.of(context).devicePixelRatio * 20,
                      glowColor: AppColors.yellow,
                      ratingWidget: RatingWidget(
                        full: Image.asset(Assets.iStar),
                        half: Image.asset(Assets.iStarHalf),
                        empty: Image.asset(Assets.iStarRounded),
                      ),
                      itemPadding: const EdgeInsets.symmetric(horizontal: 6.0),
                      updateOnDrag: true,
                      onRatingUpdate: (r) {
                        setState(() {
                          rating = r;
                        });
                      },
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonRed,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 8.0,
                        ),
                        elevation: 10,
                      ),
                      onPressed: () {
                        saveReview();
                      },
                      child: Text(
                        "Spremi recenziju".toUpperCase(),
                        style: AppTextStyles.subcategoryButtonTitle(context),
                      ),
                    ),
                  ] else ...[
                    Text(
                      "Hvala Vam na ocjeni!".toUpperCase(),
                      style: AppTextStyles.reviewMessage(context),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      Assets.iCorrect,
                      scale: 8,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
