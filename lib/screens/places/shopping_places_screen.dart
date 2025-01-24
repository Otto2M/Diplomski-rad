import 'package:flutter/material.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:transparent_image/transparent_image.dart';

class ShoppingPlacesScreen extends StatelessWidget {
  const ShoppingPlacesScreen({
    super.key,
    required this.place,
  });

  final ShoppingPlace place;

  @override
  Widget build(BuildContext context) {
    //
    // ---POPRAVITI KASNIJE ----
    //
    final List<String> images = [];

    return Card(
      color: Colors.blueGrey,
      margin: const EdgeInsets.all(20),
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 5,
      child: _buildCardContent(images),
    );
  }

  Widget _buildCardContent(List<String> images) {
    return Column(
      children: [
        Row(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(images.isNotEmpty ? images[0] : ''),
              fit: BoxFit.cover,
              height: 160,
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
                  Text(
                    place.address,
                    textAlign: TextAlign.start,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text('Radno vrijeme:'),
                  Text(
                    place.workingHours != null
                        ? place.workingHours!.entries
                            .map((entry) => '${entry.key}: ${entry.value}')
                            .join('\n')
                        : 'No working hours available',
                    //textAlign: TextAlign.start,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
