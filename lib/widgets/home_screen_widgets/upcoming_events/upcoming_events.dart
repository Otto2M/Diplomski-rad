import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

import 'package:povedi_me_app/providers/upcoming_events_provider.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/upcoming_events/event_card.dart';

class UpcomingEvents extends ConsumerWidget {
  const UpcomingEvents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingEventsAsync = ref.watch(upcomingEventsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Nadolazeće manifestacije',
            style: AppTextStyles.placeHeadline2(context),
          ),
        ),
        upcomingEventsAsync.when(
          data: (events) {
            if (events.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'Nema nadolazećih manifestacija.',
                    style: AppTextStyles.description(context),
                  ),
                ),
              );
            }

            return SizedBox(
              height: 200, // Visina horizontalnog prikaza
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                itemBuilder: (ctx, index) {
                  final event = events[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: EventCard(event: event),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Greška: $error',
                style: AppTextStyles.errorText(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
