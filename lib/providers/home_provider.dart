import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/firebase_service.dart';

class HomeProvider {
  HomeProvider();

  Future<void> updateFirestoreData(
      String collectionPath, String path, Map<String, dynamic> updateData) {
    return FirebaseService()
        .firebaseFirestore
        .collection(collectionPath)
        .doc(path)
        .update(updateData);
  }

  Stream<QuerySnapshot> getFirestoreData(
    String collectionPath,
    int limit,
  ) {
    return FirebaseService()
        .firebaseFirestore
        .collection(collectionPath)
        .limit(limit)
        .snapshots();
  }
}
