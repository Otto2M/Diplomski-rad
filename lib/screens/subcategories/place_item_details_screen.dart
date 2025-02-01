import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/widgets/custom_app_bar_with_favorite.dart';
import 'package:povedi_me_app/widgets/image_slider.dart';

class PlaceItemDetailsScreen extends ConsumerWidget {
  const PlaceItemDetailsScreen({
    super.key,
    required this.placeWithDetails,
  });

  final PlaceWithDetails placeWithDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> images = placeWithDetails.imageUrl;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBarWithFavorite(
                onBack: () {
                  Navigator.pop(context);
                },
                place: placeWithDetails,
              ),

              //Slike
              images.length > 1
                  ? ImageSlider(imagesUrl: images)
                  : Image.network(
                      images.first,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),

              //Opis
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      placeWithDetails.title.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: AppTextStyles.subcategoryPlaceTitle(context),
                    ),
                    // const SizedBox(height: 20),
                    Text(
                      placeWithDetails.address,
                      style:
                          AppTextStyles.subcategoryPlaceDetailsStyle(context),
                    ),
                    Text(
                      "Radno vrijeme:",
                      style:
                          AppTextStyles.subcategoryPlaceDetailsStyle(context),
                    ),

                    // const SizedBox(height: 20),
                    // placeWithDetails.workingHours != null
                    //     ? Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: placeWithDetails.workingHours!.entries
                    //             .map((entry) => Text('${entry.key}: ${entry.value}'))
                    //             .toList(),
                    //       )
                    //     : Text('No working hours available'),
                    Text(
                      placeWithDetails.workingHours != null
                          ? placeWithDetails.workingHours!.entries
                              .map((entry) => '${entry.key}: ${entry.value}')
                              .join('\n') // Svaki dan na novom redu
                          : 'No working hours available',
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Recenzije:".toUpperCase(),
                          style: AppTextStyles.subcategoryPlaceDetailsStyle(
                              context),
                        ),
                        Column(
                          children: [
                            for (var review in placeWithDetails.reviews!)
                              Text(
                                review,
                                style: AppTextStyles.description(context),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "O nama:",
                      style: AppTextStyles.description(context),
                    ),
                    Text(
                      placeWithDetails.description,
                      style: AppTextStyles.description(context),
                    ),
                    const SizedBox(height: 50),
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
                        onPressed: () {},
                        child: Text(
                          "Ostavi recenziju".toUpperCase(),
                          style: AppTextStyles.subcategoryButtonTitle(context),
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
    );
  }
}
