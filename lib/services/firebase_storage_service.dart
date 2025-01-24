import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Funkcija koja dohvaća slike iz određenog foldera
  Future<List<String>> fetchImagesFromFolder(String folderName) async {
    List<String> imageUrls = [];

    try {
      ListResult result = await _storage.ref().child(folderName).listAll();
      for (var item in result.items) {
        String downloadUrl = await item.getDownloadURL();
        imageUrls.add(downloadUrl);
      }
    } catch (e) {
      print("Greška pri dohvaćanju slika iz foldera $folderName: $e");
    }

    return imageUrls;
  }
}
