import 'package:povedi_me_app/models/category.dart';
import 'package:povedi_me_app/models/place.dart';

const availableCategories = [
  Category(
    id: 'c1',
    title: 'Kulturne i povijesne znamenitosti',
    icon: 'icon',
    translated: {},
  ),
  Category(
    id: 'c2',
    title: 'Mainfestacije',
    icon: 'icon',
    translated: {},
  ),
  Category(
    id: 'c3',
    title: 'Gastronomija',
    icon: 'icon',
    translated: {},
  ),
  Category(
    id: 'c4',
    title: 'Smještaj',
    icon: 'icon',
    translated: {},
  ),
  Category(
    id: 'c5',
    title: 'Sport i rekreacija',
    icon: 'icon',
    translated: {},
  ),
  Category(
    id: 'c6',
    title: 'Prirodne atrakcije',
    icon: 'icon',
    translated: {},
  ),
  Category(
    id: 'c7',
    title: 'OPG-ovi',
    icon: 'icon',
    translated: {},
  ),
];

//samo te 2 kategorije sadrže podkategorije
const availableSubcategories = [
  Subcategory(
    id: 'sc1',
    categoryId: 'c4',
    title: 'Hoteli',
  ),
  Subcategory(
    id: 'sc2',
    categoryId: 'c4',
    title: 'Apartmani',
  ),
  Subcategory(
    id: 'sc3',
    categoryId: 'c4',
    title: 'Kampovi',
  ),
  Subcategory(
    id: 'sc3',
    categoryId: 'c3',
    title: 'Restorani',
  ),
  Subcategory(
    id: 'sc3',
    categoryId: 'c3',
    title: 'Kafići',
  ),
];

// dummy_places.dart
const availablePlaces = [
  Place(
    id: 'p10',
    categoryId: 'c4',
    subcategoryId: 'sc1',
    title: 'Hotel Podravina',
    description: 'Hotel u Koprivnici.',
    imageUrl: ['https://example.com/hotel-esplanade.jpg'],
    address: 'Zagreb, Hrvatska',
    coordinates: {
      'latitude': 45.123456,
      'longitude': 12.654321,
    },
    type: 'basic',
  ),
  Place(
    id: 'p11',
    categoryId: 'c1',
    subcategoryId: null,
    title: 'Dioklecijanova palača',
    description: 'Jedna od najbolje očuvanih građevina iz rimskog doba.',
    imageUrl: ['https://enciklopedija.hr/slike/he/slike/HEW_096.jpg'],
    address: 'Split, Hrvatska',
    coordinates: {
      'latitude': 45.123456,
      'longitude': 12.654321,
    },
    type: 'basic',
  ),
  Place(
    id: 'p1',
    categoryId: 'c1',
    subcategoryId: null,
    title: 'Dioklecijanova palača',
    description: 'Jedna od najbolje očuvanih građevina iz rimskog doba.',
    imageUrl: ['https://enciklopedija.hr/slike/he/slike/HEW_096.jpg'],
    address: 'Split, Hrvatska',
    coordinates: {
      'latitude': 45.123456,
      'longitude': 12.654321,
    },
    type: 'basic',
  ),
  Place(
    id: 'p2',
    categoryId: 'c3',
    subcategoryId: 'sc3',
    title: 'Konoba Mate',
    description: 'Tradicionalna dalmatinska konoba s domaćim specijalitetima.',
    imageUrl: ['https://example.com/konoba-mate.jpg'],
    address: 'Korčula, Hrvatska',
    coordinates: {
      'latitude': 45.123456,
      'longitude': 12.654321,
    },
    type: 'basic',
  ),
  Place(
    id: 'p3',
    categoryId: 'c6',
    subcategoryId: null,
    title: 'Plitvička jezera',
    description: 'Najstariji i najveći nacionalni park u Hrvatskoj.',
    imageUrl: ['https://example.com/plitvice.jpg'],
    address: 'Plitvička jezera, Hrvatska',
    coordinates: {
      'latitude': 45.123456,
      'longitude': 12.654321,
    },
    type: 'basic',
  ),
  Place(
    id: 'p4',
    categoryId: 'c4',
    subcategoryId: 'sc1',
    title: 'Hotel Esplanade',
    description: 'Luksuzni hotel s pet zvjezdica u centru Zagreba.',
    imageUrl: ['https://example.com/hotel-esplanade.jpg'],
    address: 'Zagreb, Hrvatska',
    coordinates: {
      'latitude': 45.123456,
      'longitude': 12.654321,
    },
    type: 'basic',
  ),
  Place(
    id: 'p5',
    categoryId: 'c2',
    subcategoryId: null,
    title: 'Dubrovačke ljetne igre',
    description: 'Kultura, glazba i kazalište u povijesnom Dubrovniku.',
    imageUrl: ['https://example.com/dubrovacke-igre.jpg'],
    address: 'Dubrovnik, Hrvatska',
    coordinates: {
      'latitude': 45.123456,
      'longitude': 12.654321,
    },
    type: 'basic',
  ),
  Place(
    id: 'p6',
    categoryId: 'c7',
    subcategoryId: null,
    title: 'OPG Ivanić',
    description: 'Proizvodnja domaćeg meda i prirodnih proizvoda.',
    imageUrl: ['https://example.com/opg-ivanic.jpg'],
    address: 'Ivanić Grad, Hrvatska',
    coordinates: {
      'latitude': 45.123456,
      'longitude': 12.654321,
    },
    type: 'basic',
  ),
];

const placeWithDetails = [
  PlaceWithDetails(
    id: '2',
    categoryId: 'gastronomija',
    subcategoryId: 'restorani',
    title: 'Restoran Podravka',
    description: 'Izvrstan restoran s lokalnim specijalitetima.',
    imageUrl: ['https://example.com/podravka.jpg'],
    address: 'Ulica Podravska 12',
    coordinates: {'lat': 46.1635, 'lng': 16.8342},
    workingHours: {'ponedjeljak': '9:00-22:00', 'utorak': '9:00-22:00'},
    reviews: ['Odlično!', 'Preporučujem!'],
    contactNumber: '+385912345678',
    email: 'info@restoran-podravka.hr',
    type: 'details',
  ),
];
