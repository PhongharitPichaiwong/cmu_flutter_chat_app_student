import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> getRemoteUserList(String uid) async {
    final QuerySnapshot result = await firebaseFirestore
        .collection('users')
        .where('id', isEqualTo: uid)
        .get();
    return result.docs;
  }

  Future<User?> getRemoteUserData(AuthCredential credential) async {
    User? firebaseUser =
        (await FirebaseService().firebaseAuth.signInWithCredential(credential))
            .user;
    return firebaseUser;
  }
}
