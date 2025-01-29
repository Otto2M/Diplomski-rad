//klasa za: opcenito o gradu - pocetni zasloni
class AboutCity {
  AboutCity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String? subtitle;
  final String description;
  final List<String> imageUrl;
}

class PerfectDay {
  PerfectDay({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.sections,
    required this.additionalTips,
    required this.conclusion,
  });

  final String title;
  final String description;
  final String imageUrl;
  final List<Section> sections;
  final String? additionalTips;
  final String conclusion;
}

class Section {
  final String timeOfDay; // Vrijeme dana (Prijepodne, Poslijepodne, Večer)
  final String content;

  Section({
    required this.timeOfDay,
    required this.content,
  });
}
