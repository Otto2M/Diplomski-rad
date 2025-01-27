import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/models/city.dart';
import 'package:povedi_me_app/services/cloud_firestore_service.dart';

final firestoreDatabaseService =
    Provider<FirestoreDatabaseService>((ref) => FirestoreDatabaseService());

// AsyncProvider za dohvaćanje svih "Savršenih dana"
final perfectDaysProvider = FutureProvider<List<PerfectDay>>((ref) async {
  final firebaseFirestoreService = ref.watch(firestoreDatabaseService);
  return await firebaseFirestoreService.getAllPerfectDaysData();
});
