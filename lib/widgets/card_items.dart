import 'package:flutter/material.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/screens/subcategories/place_item_details_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class CardItems extends StatelessWidget {
  const CardItems({
    super.key,
    required this.place,
    required this.isInteractive,
  });

  final PlaceWithDetails place;
  final bool isInteractive;

  @override
  Widget build(BuildContext context) {
    final List<String> images = place.imageUrl;

    return Card(
      color: Colors.blueGrey,
      margin: const EdgeInsets.all(20),
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 5,
      child: isInteractive
          ? InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PlaceItemDetailsScreen(
                      placeWithDetails: place,
                    ),
                  ),
                );
              },
              child: _buildCardContent(images),
            )
          : _buildCardContent(images),
    );
  }

  Widget _buildCardContent(List<String> images) {
    return Column(
      children: [
        Row(
          children: [
            for (var imageUrl in images)
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(
                  //imageUrl,
                  imageUrl.isNotEmpty ? imageUrl : '',
                ),
                fit: BoxFit.cover,
                height: 150,
                width: 150,
              ),
            Container(
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Column(
                children: [
                  Text(
                    place.title,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const Text('Recenzija'),
                  // const PlaceItemInfoReview(icon: Icons.star),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
