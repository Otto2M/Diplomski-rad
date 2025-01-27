import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            const SizedBox(height: 16),
            Expanded(
              child: perfectDaysAsyncValue.when(
                data: (perfectDays) {
                  if (perfectDays.isEmpty) {
                    return const Center(
                      child: Text('Nema dostupnih podataka za prikaz.'),
                    );
                  } else if (perfectDays.length == 1) {
                    // Automatski prikaz detalja ako postoji samo jedan zapis
                    final singlePerfectDay = perfectDays.first;
                    return PerfectDayDetailsScreen(
                        perfectDay: singlePerfectDay);
                  } else {
                    // Prikaz liste svih savršenih dana
                    return ListView.builder(
                      itemCount: perfectDays.length,
                      itemBuilder: (context, index) {
                        final perfectDay = perfectDays[index];
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.network(
                              perfectDay.imageUrl,
                              width: 100,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            title: Text(perfectDay.title),
                            subtitle: Text(
                              perfectDay.conclusion,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PerfectDayDetailsScreen(
                                      perfectDay: perfectDay),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: Text('Greška: $error'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
