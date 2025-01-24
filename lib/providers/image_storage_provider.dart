import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/services/cloud_firestore_service.dart';
import 'package:povedi_me_app/services/firebase_storage_service.dart';

final firebaseStorage =
    Provider<FirebaseStorageService>((ref) => FirebaseStorageService());

final firestoreDatabaseService =
    Provider<FirestoreDatabaseService>((ref) => FirestoreDatabaseService());

// Riverpod FutureProvider za dohvat slika iz foldera prema kategorijama

//Kulturne i povijesne znamenitosti
final folder1ImagesProvider = FutureProvider<List<String>>((ref) async {
  final firebaseStorageService = ref.watch(firebaseStorage);
  final galleryImagesUrl = await firebaseStorageService.fetchImagesFromFolder(
      'kulturnePovijesneZnamenitosti/galerija/'); // ----------- putanju mogu postaviti u folder za konstante -----------
  print("----------- URL slika : ------> ${galleryImagesUrl} <-----------");

  final firebaseFirestoreService = ref.watch(firestoreDatabaseService);
  //firebaseFirestoreService.saveImageUrlsToPlace(placeId, galleryImagesUrl);

  return galleryImagesUrl;
});

//Manifestacije
final folder2ImagesProvider = FutureProvider<List<String>>((ref) async {
  final firebaseStorageService = ref.watch(firebaseStorage);
  return await firebaseStorageService.fetchImagesFromFolder('folder2');
});

//Sport
final folder3ImagesProvider = FutureProvider<List<String>>((ref) async {
  final firebaseStorageService = ref.watch(firebaseStorage);
  return await firebaseStorageService.fetchImagesFromFolder('folder3');
});

//OPG-ovi
final folder4ImagesProvider = FutureProvider<List<String>>((ref) async {
  final firebaseStorageService = ref.watch(firebaseStorage);
  return await firebaseStorageService.fetchImagesFromFolder('folder4');
});
