//klasa za: kulturne i povijesne znamenitosti,
//manifestacije, sport i rekreacija, prirodne atrakcije,
//industrijska središta i okolica

class Place {
  const Place({
    required this.id,
    required this.categoryId,
    required this.subcategoryId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.address,
    required this.coordinates,
    required this.type,
  });

  final String id;
  final String categoryId; // Veza s kategorijom (Category.id)
  final String?
      subcategoryId; //Potrebno za kateogriju smještaj i gastronomski kutak
  final String title;
  final String description;
  final List<String> imageUrl;
  final String address;
  final Map<String, double> coordinates;
  final String type; //"type": "details" ili "basic" ili "shop"
}

//klasa za katgorije: gastronomija, smještaj i OPG
//- (imaju dodatne atribute, podatke)
// Specifična klasa za mjesta s dodatnim atributima
class PlaceWithDetails extends Place {
  const PlaceWithDetails({
    required super.id,
    required super.categoryId,
    required super.subcategoryId,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.address,
    required super.coordinates,
    required super.type,
    required this.workingHours,
    required this.reviews,
    this.contactNumber,
    this.email,
  });

  final Map<String, String>? workingHours; // Npr. {"ponedjeljak": "8:00-16:00"}
  final List<String>? reviews;
  final String? contactNumber;
  final String? email;
}

//klasa za kategoriju: trgovački centri
class ShoppingPlace extends Place {
  const ShoppingPlace({
    required super.id,
    required super.categoryId,
    required super.subcategoryId,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.address,
    required super.coordinates,
    required super.type,
    required this.workingHours,
  });

  final Map<String, String>? workingHours;
}

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
  final String imageUrl;
}


//TO DO
//Dodati potrebne ostale objekte/zasebne klase za pojedine kategorije/zaslone u aplikaciji koje imaju dodatne informacije
