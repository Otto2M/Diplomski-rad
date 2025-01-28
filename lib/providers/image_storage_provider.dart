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
  // final imagesUrl = await firebaseStorageService.fetchImagesFromFolder(
  //     'kulturnePovijesneZnamenitosti/muzejKc/'); // ----------- putanju mogu postaviti u folder za konstante -----------
  // print("----------- URL slika : ------> ${imagesUrl} <-----------");

  final imagesUrl = await firebaseStorageService.fetchImagesFromFolder(
      '/manifestacije/podravskiMotivi/'); // ----------- putanju mogu postaviti u folder za konstante -----------
  print("----------- URL slika : ------> ${imagesUrl} <-----------");

  final firebaseFirestoreService = ref.watch(firestoreDatabaseService);
  // firebaseFirestoreService.saveImageUrlsToPlace(
  //     , imagesUrl);

  return imagesUrl;
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
