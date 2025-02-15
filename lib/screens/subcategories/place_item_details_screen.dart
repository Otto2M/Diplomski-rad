import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/providers/places_provider.dart';
import 'package:povedi_me_app/providers/user_provider.dart';
import 'package:povedi_me_app/screens/subcategories/place_reviews_screen.dart';
import 'package:povedi_me_app/services/cloud_firestore_service.dart';
import 'package:povedi_me_app/services/place_details_service.dart';
import 'package:povedi_me_app/widgets/custom_app_bar_with_favorite.dart';
import 'package:povedi_me_app/widgets/image_slider.dart';
import 'package:povedi_me_app/widgets/reviews/rating_star_bar.dart';
import 'package:povedi_me_app/widgets/side_dialog.dart';
import 'package:povedi_me_app/widgets/working_hours_place.dart';

class PlaceItemDetailsScreen extends ConsumerStatefulWidget {
  const PlaceItemDetailsScreen({
    super.key,
    required this.placeWithDetails,
  });

  final PlaceWithDetails placeWithDetails;

  @override
  ConsumerState<PlaceItemDetailsScreen> createState() {
    return _PlaceItemDetailsScreenState();
  }
}

class _PlaceItemDetailsScreenState
    extends ConsumerState<PlaceItemDetailsScreen> {
  bool _isDialogVisible = false;

  String? workingHours;
  bool? openNow;
  double? rating;
  bool isLoadingWorkingHours = true;

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  void _toggleDialog() {
    setState(() {
      _isDialogVisible = !_isDialogVisible;
    });
  }

  void fetchDetails() async {
    final String placeName = widget.placeWithDetails.title.trim();

    setState(() {
      isLoadingWorkingHours = true;
    });

    final details = await ref
        .read(placeDetailsServiceProvider)
        .fetchPlaceDetails(placeName: placeName);

    setState(() {
      workingHours = details['workingHours'];
      openNow = details['openNow'];
      rating = details['rating'];
      isLoadingWorkingHours = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userProvider);

    Widget userReviewWidget = const SizedBox();
    Function()? leaveReviewAction;
    FirestoreDatabaseService _firebaseService = FirestoreDatabaseService();

    userAsyncValue.when(
      data: (user) {
        if (user == null) {
          // Korisnik nije prijavljen
          userReviewWidget = Text(
            "Nema recenzije (prijavite se)",
            style: AppTextStyles.description(context),
          );
          leaveReviewAction = () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Prijavite se da ostavite recenziju.')),
            );
          };
        } else {
          // Provjera korisničke recenzije za trenutno mjesto
          final userReview = user.reviews?[widget.placeWithDetails.id];
          if (userReview != null) {
            // Korisnik je ostavio recenziju
            userReviewWidget = Text(
              "Ocjena: ${userReview.toStringAsFixed(1)}",
              style: AppTextStyles.description(context),
            );
          } else {
            // Korisnik nije ostavio recenziju
            userReviewWidget = Text(
              "Nema recenzije",
              style: AppTextStyles.description(context),
            );
          }
          leaveReviewAction = () async {
            final reviewAdded = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PlaceReviewsScreen(
                  placeWithDetails: widget.placeWithDetails,
                  userId: user.id,
                ),
              ),
            );
            if (reviewAdded == true) {
              // Dohvati sve recenzije za ovo mjesto
              final reviewsMap = await _firebaseService
                  .getAllReviewsForPlace(widget.placeWithDetails.id);

              // Ažuriraj prosječnu ocjenu u kolekciji places
              await _firebaseService.updateAverageRating(
                placeId: widget.placeWithDetails.id,
                userReviews: reviewsMap,
              );

              ref.invalidate(userProvider);
            }
          };
        }
      },
      loading: () {
        userReviewWidget = const CircularProgressIndicator();
        leaveReviewAction = null;
      },
      error: (error, stackTrace) {
        userReviewWidget = Text(
          "Greška pri dohvaćanju recenzije",
          style: AppTextStyles.errorText(context),
        );
        leaveReviewAction = null;
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(userProvider);
                ref.invalidate(placesProvider);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // App Bar
                    CustomAppBarWithFavorite(
                      onBack: () => Navigator.pop(context),
                      place: widget.placeWithDetails,
                    ),

                    // Slike
                    widget.placeWithDetails.imageUrl.length > 1
                        ? ImageSlider(
                            imagesUrl: widget.placeWithDetails.imageUrl)
                        : Image.network(
                            widget.placeWithDetails.imageUrl.first,
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                          ),

                    // Opis mjesta i korisničke recenzije
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Naziv mjesta
                          GestureDetector(
                            onTap: _toggleDialog,
                            child: Row(
                              children: [
                                Text(
                                  widget.placeWithDetails.title.toUpperCase(),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: AppTextStyles.subcategoryPlaceTitle(
                                      context),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          if (isLoadingWorkingHours)
                            const CircularProgressIndicator(
                              strokeWidth: 2,
                            )
                          else ...[
                            RatingStarBar(
                              rating: rating ?? 0.0,
                              isCardItemBar: false,
                            ),
                          ],

                          const SizedBox(height: 20),

                          // Adresa i radno vrijeme
                          Text(
                            "Adresa: ${widget.placeWithDetails.address}",
                            style: AppTextStyles.subcategoryPlaceDetailsStyle(
                                context),
                          ),
                          const SizedBox(height: 10),

                          WorkingHoursPlace(
                            workingHours: workingHours ??
                                "Nema dostupnih podataka o radnom vremenu.",
                            openNow: openNow ?? false,
                            isLoadingWorkingHours: isLoadingWorkingHours,
                            isShop: false,
                          ),

                          // Korisnička recenzija
                          Row(
                            children: [
                              Text(
                                "Moja recenzija:".toUpperCase(),
                                style:
                                    AppTextStyles.subcategoryPlaceDetailsStyle(
                                        context),
                              ),
                              const SizedBox(width: 10),
                              Expanded(child: userReviewWidget),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Opis mjesta
                          Text(
                            "O nama:",
                            style: AppTextStyles.subcategoryPlaceDetailsStyle(
                                context),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            widget.placeWithDetails.description,
                            textAlign: TextAlign.justify,
                            style: AppTextStyles.description(context),
                          ),

                          const SizedBox(height: 50),

                          // Gumb za ostavljanje recenzije
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.buttonRed,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                  vertical: 8.0,
                                ),
                                elevation: 10,
                              ),
                              onPressed: leaveReviewAction,
                              child: Text(
                                "Ostavi recenziju".toUpperCase(),
                                style: AppTextStyles.subcategoryButtonTitle(
                                    context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SideDialog(
              place: widget.placeWithDetails,
              isDialogVisible: _isDialogVisible,
              onDismiss: _toggleDialog,
            ),
          ],
        ),
      ),
    );
  }
}
