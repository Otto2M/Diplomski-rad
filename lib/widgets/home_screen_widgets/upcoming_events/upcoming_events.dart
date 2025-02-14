import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

import 'package:povedi_me_app/providers/upcoming_events_provider.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/upcoming_events/event_card.dart';

class UpcomingEvents extends ConsumerStatefulWidget {
  const UpcomingEvents({super.key});

  @override
  ConsumerState<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends ConsumerState<UpcomingEvents> {
  bool ascendingOrder = true;

  void sortEvents(List<dynamic> events) {
    if (ascendingOrder) {
      events.sort((a, b) => a.date.compareTo(b.date));
    } else {
      events.sort((a, b) => b.date.compareTo(a.date));
    }
  }

  @override
  Widget build(BuildContext context) {
    final upcomingEventsAsync = ref.watch(upcomingEventsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nadolazeće manifestacije',
                style: AppTextStyles.placeHeadline2(context),
              ),
              Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_upward_rounded),
                      onPressed: () {
                        setState(() {
                          ascendingOrder = true;
                        });
                      }),
                  IconButton(
                    icon: const Icon(Icons.arrow_downward_rounded),
                    onPressed: () {
                      setState(() {
                        ascendingOrder = false;
                      });
                    },
                  ),
                ],
              ),
            ],
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

            sortEvents(events);

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
