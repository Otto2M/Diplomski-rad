import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

import 'package:povedi_me_app/providers/perfect_day_provider.dart';
import 'package:povedi_me_app/screens/home/perfect_day_details_screen.dart';
import 'package:povedi_me_app/widgets/custom_app_bar.dart';

class PerfectDayListScreen extends ConsumerWidget {
  const PerfectDayListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final perfectDaysAsyncValue = ref.watch(perfectDaysProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Savršen dan u KC",
              onBack: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: perfectDaysAsyncValue.when(
                data: (perfectDays) {
                  if (perfectDays.isEmpty) {
                    return Center(
                      child: Text(
                        'Nema dostupnih podataka za prikaz.',
                        style: AppTextStyles.description(context),
                      ),
                    );
                  } else if (perfectDays.length == 1) {
                    // Automatski prikaz detalja ako postoji samo jedan zapis
                    final singlePerfectDay = perfectDays.first;
                    return PerfectDayDetailsScreen(
                      perfectDay: singlePerfectDay,
                    );
                  } else {
                    // Prikaz liste svih savršenih dana
                    return ListView.builder(
                      itemCount: perfectDays.length,
                      itemBuilder: (context, index) {
                        final perfectDay = perfectDays[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PerfectDayDetailsScreen(
                                    perfectDay: perfectDay),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.all(10.0),
                            color: Theme.of(context).colorScheme.secondary,
                            elevation: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                  child: Image.network(
                                    perfectDay.imageUrl,
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10.0,
                                    right: 10.0,
                                    bottom: 10.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Naslov
                                      Text(
                                        perfectDay.title,
                                        style: AppTextStyles.pdSectionTitle(
                                            context),
                                      ),
                                      // Opis
                                      Text(
                                        perfectDay.conclusion,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                        style:
                                            AppTextStyles.description(context),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: Text(
                    'Greška prilikom učitavanja podataka: $error',
                    style: AppTextStyles.errorText(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
