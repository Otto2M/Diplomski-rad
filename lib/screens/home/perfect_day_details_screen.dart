import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

import 'package:povedi_me_app/models/city.dart';
import 'package:povedi_me_app/widgets/custom_app_bar.dart';
import 'package:povedi_me_app/widgets/image_with_error_handling.dart';

class PerfectDayDetailsScreen extends StatelessWidget {
  const PerfectDayDetailsScreen({
    super.key,
    required this.perfectDay,
  });

  final PerfectDay perfectDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              CustomAppBar(
                title: perfectDay.title,
                onBack: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 16),
              // Slika
              ImageWithErrorHandling(
                imageUrl: perfectDay.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                isCard: true,
              ),
              // ClipRRect(
              //   child: Image.network(
              //     perfectDay.imageUrl,
              //     width: double.infinity,
              //     height: 250,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              const SizedBox(height: 16.0),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Naslov
                    Text(
                      perfectDay.title.toUpperCase(),
                      style: AppTextStyles.categoryHeadline(context),
                    ),
                    const SizedBox(height: 8.0),

                    // Opis
                    Text(
                      perfectDay.description,
                      textAlign: TextAlign.justify,
                      style: AppTextStyles.pdGeneralDescription(context),
                    ),
                    const SizedBox(height: 16.0),

                    // Sekcije (prijepodne, poslijepodne, večer)
                    for (var section in perfectDay.sections) ...[
                      Text(
                        section.timeOfDay,
                        style: AppTextStyles.pdSectionTitle(context),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        section.content,
                        textAlign: TextAlign.justify,
                        style: AppTextStyles.description(context),
                      ),
                      const SizedBox(height: 16.0),
                    ],

                    // Dodatni savjeti
                    if (perfectDay.additionalTips?.isNotEmpty ?? false) ...[
                      const Divider(),
                      Text(
                        'Dodatni savjeti',
                        style: AppTextStyles.pdSectionTitle(context),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        perfectDay.additionalTips!,
                        style: AppTextStyles.description(context),
                      ),
                    ],
                    const SizedBox(height: 16.0),
                    const Divider(),
                    const SizedBox(height: 16.0),
                    // Zaključak
                    Text(
                      perfectDay.conclusion,
                      style: AppTextStyles.pdGeneralDescription(context),
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
