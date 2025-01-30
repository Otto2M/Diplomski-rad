import 'package:flutter/material.dart';
import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/screens/home/about_city_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class GeneralAi extends StatefulWidget {
  const GeneralAi({super.key});

  @override
  State<GeneralAi> createState() => _GeneralAiState();
}

class _GeneralAiState extends State<GeneralAi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      child: Stack(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: const AssetImage(Assets.homeScreenBackgroundImage),
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
                  builder: (context) => const AboutCityScreen(),
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Manje zaobljeni rubovi
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 25,
                ), //Visina gumba
                elevation: 20,
                overlayColor: Colors.black26,
              ),
              child: const Text(
                "O KOPRIVNICI",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            //   child: FloatingActionButton(
            //     onPressed: () {
            //       ScaffoldMessenger.of(context).clearSnackBars();
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text('ChatBot pressed'),
            //           backgroundColor: Colors.deepPurple,
            //           elevation: 5,
            //           duration: const Duration(seconds: 3),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(20),
            //           ),
            //           padding: const EdgeInsets.symmetric(
            //             vertical: 15,
            //             horizontal: 10,
            //           ),
            //         ),
            //       );
            //     },
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(50),
            //     ),
            //     backgroundColor: Colors.blue,
            //     child: const Icon(
            //       Icons.chat_rounded,
            //       size: 30,
            //     ),
            //   ),
            // ),
            child: CircleAvatar(
              radius: 40,
              //backgroundImage: AssetImage(Assets.aiButton),
              child: IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('ChatBot pressed'),
                      backgroundColor: Colors.deepPurple,
                      elevation: 5,
                      duration: const Duration(seconds: 3),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Manje zaobljeni rubovi
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ), //Visina gumba
                    ),
                  );
                },
                icon: const Icon(
                  Icons.chat_rounded,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
