import 'package:flutter/material.dart';

import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/screens/places/place_details_category_screen.dart';

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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceDetailsCategoryScreen(
                place: widget.event), //EventDetailsScreen(event: widget.event),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.event.imageUrl.isNotEmpty
                    ? widget.event.imageUrl.first
                    : Assets.logo,

                //
                // ----------- POSTAVITI SLIKU NA FIREBASE STORAGE DA SE OD TAMO DOHVAĆA,
                //OVAKO NE RADI ZBOG METODE IMAGE.NETWORK ------------------
                //

                width: 180,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 180,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.event.title,
                  style: const TextStyle(color: Colors.white),
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
