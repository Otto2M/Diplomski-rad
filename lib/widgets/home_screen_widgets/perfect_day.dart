import 'package:flutter/material.dart';
import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:povedi_me_app/screens/home/perfect_day_list_screen.dart';

class PerfectDay extends StatelessWidget {
  const PerfectDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 50),
      child: Stack(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: const AssetImage(Assets.homeScreenPerfectdayImage),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            imageErrorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    'Slika nije dostupna',
                    style: AppTextStyles.description(context),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 15,
            left: 20,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PerfectDayListScreen(),
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 25,
                ),
                elevation: 20,
                overlayColor: Colors.black26,
              ),
              child: Text(
                "SAVRŠEN DAN U KC",
                style: AppTextStyles.homeScreenYellowButtons(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
