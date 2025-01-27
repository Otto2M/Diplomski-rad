import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/providers/categories_provider.dart';
import 'package:povedi_me_app/widgets/custom_app_bar.dart';

class AboutCityScreen extends ConsumerWidget {
  const AboutCityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aboutCityAsyncValue = ref.watch(aboutCityDataProvider);

    return Scaffold(
      body: aboutCityAsyncValue.when(
        data: (aboutCityData) {
          final place = aboutCityData.isNotEmpty ? aboutCityData[0] : null;

          if (place == null) {
            return const Center(child: Text('Grad nije pronađen.'));
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(
                    onBack: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(place.title),
                        const SizedBox(height: 20),
                        Text(place.description),
                        const SizedBox(height: 20),
                        GridView.builder(
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
                            final imageUrl = place.imageUrl[index];
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                height: 120,
                                width: 150,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
          //);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child:
              Text('Došlo je do greške prilikom učitavanja podataka: $error'),
        ),
      ),
    );
  }
}
