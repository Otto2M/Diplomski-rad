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
    final List<String> imagesUrl = place.imageUrl;

    return Card(
      color: Colors.blueGrey,
      margin: isInteractive
          ? const EdgeInsets.all(20)
          : const EdgeInsets.only(top: 20, left: 3),
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 10,
      child: SizedBox(
        width: 350,
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
                child: _buildCardContent(imagesUrl),
              )
            : _buildCardContent(imagesUrl),
      ),
    );
  }

  Widget _buildCardContent(List<String> imagesUrl) {
    return Row(
      children: [
        FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: NetworkImage(
            imagesUrl.isNotEmpty ? imagesUrl[0] : '',
          ),
          fit: BoxFit.cover,
          height: 160,
          width: 160,
        ),
        Container(
          width: 190,
          color: Colors.black54,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                place.title,
                maxLines: 2,
                textAlign: TextAlign.center,
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
    );
  }
}
