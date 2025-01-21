import 'package:flutter/material.dart';
import 'package:povedi_me_app/models/place.dart';

class PlaceDetailsCategoryScreen extends StatelessWidget {
  const PlaceDetailsCategoryScreen({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          bottom: 30,
          left: 30,
          right: 30,
          top: 15,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_left_rounded,
                      ),
                      iconSize: 50,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.heart_broken,
                      ),
                      iconSize: 40,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(place.title),
                const SizedBox(height: 20),
                Text(place.description),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: place.imageUrl.length, // Broj slika
                  itemBuilder: (context, index) {
                    final imageUrl = place.imageUrl[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        height: 120,
                        width: 150,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
