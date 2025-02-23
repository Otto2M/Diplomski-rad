import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/widgets/card_items.dart';

class OpgPlacesScreen extends ConsumerStatefulWidget {
  const OpgPlacesScreen({
    super.key,
    required this.place,
  });

  final PlaceWithDetails place;

  @override
  ConsumerState<OpgPlacesScreen> createState() => _OpgPlacesScreenState();
}

class _OpgPlacesScreenState extends ConsumerState<OpgPlacesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CardItems(
        place: widget.place,
        isInteractive: true,
      ),
    );

    // Card(
    //   color: Theme.of(context).colorScheme.primary,
    //   margin: const EdgeInsets.all(20),
    //   shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
    //   elevation: 10,
    //   child: _buildCardContent(),
    // );
  }
}
