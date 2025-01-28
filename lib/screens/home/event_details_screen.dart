import 'package:flutter/material.dart';
import 'package:povedi_me_app/models/place.dart';

class EventDetailsScreen extends StatelessWidget {
  final Place event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Slika
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                event.imageUrl.isNotEmpty
                    ? event.imageUrl.first
                    : 'https://via.placeholder.com/150',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Naslov
            Text(
              event.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Opis
            Text(
              event.description ?? 'Nema opisa dostupnog.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // Datum
            if (event.date != null)
              Text(
                'Datum održavanja: ${_formatDate(event.date)}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            const SizedBox(height: 16),
            // Ostali podaci (adresa, kontakt...)
            if (event.address != null) ...[
              Text('Adresa: ${event.address}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Nepoznato';
    return '${date.day}.${date.month}.${date.year}.';
  }
}
