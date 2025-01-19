//za odabir jezika i objasnjena nekih dijelova aplikacije

import 'package:flutter/material.dart';
import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Dobrodošli u aplikaciju",
      "description": "Ovdje možete pronaći najbolje opcije za vas.",
      "image": Assets.logo
    },
    {
      "title": "Odaberite jezik",
      "description": "Prije početka odaberite željeni jezik aplikacije",
      "image": Assets.logo
    },
    {
      "title": "Počnimo!",
      "description":
          "Kliknite dalje kako biste krenuli s korištenjem aplikacije.",
      "image": Assets.logo
    },
    {
      "title": "Dobrodošli!",
      "description": "Prijavite se ili registrirajte kako biste nastavili.",
      "image": Assets.logo
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: _onboardingData.length,
        itemBuilder: (context, index) => OnboardingContent(
          title: _onboardingData[index]["title"]!,
          description: _onboardingData[index]["description"]!,
          image: _onboardingData[index]["image"]!,
        ),
      ),
      bottomSheet: _currentPage == _onboardingData.length - 1
          ? TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              },
              child: Text("Kreni dalje", style: TextStyle(fontSize: 18)),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _pageController.jumpToPage(2),
                  child: Text("Preskoči"),
                ),
                Row(
                  children: List.generate(
                    _onboardingData.length,
                    (index) => buildDot(index, context),
                  ),
                ),
                TextButton(
                  onPressed: () => _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  ),
                  child: Text("Dalje"),
                ),
              ],
            ),
    );
  }

//prebaciti u folder widgets
  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: _currentPage == index ? 20 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String title, description, image;

  const OnboardingContent({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 300),
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
