import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:povedi_me_app/screens/home/perfect_day_list_screen.dart';

class PerfectDay extends StatelessWidget {
  const PerfectDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      color: Colors.blue,
      margin: const EdgeInsets.symmetric(vertical: 50),
      child: Stack(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: const NetworkImage(
                "https://drava.info/wp-content/uploads/2023/04/343318975_2395768270604311_7363034214388749621_n.jpg"),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            bottom: 15,
            left: 20,
            //definirati globalni izgled za te buttone
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PerfectDayListScreen(),
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Manje zaobljeni rubovi
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 25,
                ), //Visina gumba
                elevation: 20,
                overlayColor: Colors.black26,
              ),
              child: const Text(
                "SAVRŠEN DAN U KC",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
