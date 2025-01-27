import 'package:flutter/material.dart';

import 'package:povedi_me_app/models/city.dart';
import 'package:povedi_me_app/widgets/custom_app_bar.dart';

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
              ClipRRect(
                child: Image.network(
                  perfectDay.imageUrl,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Naslov
                    Text(perfectDay.title),
                    const SizedBox(height: 8.0),

                    // Opis
                    Text(
                      perfectDay.description,
                      //style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(height: 16.0),

                    // Sekcije (prijepodne, poslijepodne, večer)
                    for (var section in perfectDay.sections) ...[
                      Text(
                        section.timeOfDay,
                      ),
                      const SizedBox(height: 4.0),
                      Text(section.content),
                      const SizedBox(height: 16.0),
                    ],

                    // Dodatni savjeti
                    if (perfectDay.additionalTips?.isNotEmpty ?? false) ...[
                      const Divider(),
                      const Text(
                        'Dodatni savjeti',
                        // style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        //       fontWeight: FontWeight.bold,
                        //     ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(perfectDay.additionalTips!),
                    ],

                    const Divider(),

                    // Zaključak
                    Text(
                      perfectDay.conclusion,
                      //style: Theme.of(context).textTheme.bodyText1,
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
