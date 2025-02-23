import 'package:flutter/material.dart';

import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/screens/places/place_details_category_screen.dart';
import 'package:povedi_me_app/widgets/image_with_error_handling.dart';

class EventCard extends StatefulWidget {
  const EventCard({
    super.key,
    required this.event,
  });

  final Place event;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isHovered = false;

  String _formatDate(DateTime? date) {
    if (date == null) return 'Nepoznato';
    return '${date.day}.${date.month}.${date.year}.';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaceDetailsCategoryScreen(
                place: widget.event,
              ), //EventDetailsScreen(event: widget.event),
            ),
          );
        },
        onLongPress: () => setState(() => isHovered = true),
        onLongPressUp: () => setState(() => isHovered = false),
        child: MouseRegion(
          onHover: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: Stack(
            children: [
              widget.event.imageUrl.isEmpty
                  ? Container(
                      width: 180,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Ova manifestacija ne sadrži slike",
                          style: AppTextStyles.description(context),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                    )
                  : ImageWithErrorHandling(
                      imageUrl: widget.event.imageUrl.first,
                      width: 180,
                      height: 200,
                      fit: BoxFit.cover,
                      isEventCard: true,
                    ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 180,
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.event.title,
                    style: AppTextStyles.ueTitleStyle(context),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              // Hover efekt: tamna pozadina s datumom
              if (isHovered)
                Container(
                  width: 180,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _formatDate(widget.event.date),
                    style: AppTextStyles.ueDateStyle(context),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
