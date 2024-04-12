
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parley/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future setData(String refId, String docId, Map<String, dynamic> data) async {
    await _firestore.collection(refId).doc(docId).set(data);
  }

  Future setDoc(String docId, Map<String, dynamic> data) async {
    await _firestore.doc(docId).set(data);
  }

  Future setUser(UserModel user) async {
    await _firestore.collection('users').doc(user.uid!).set(user.toJson());
  }

  Future<UserModel?> getUser(String uid) async {
    var data = await _firestore.collection('users').doc(uid).get();
    if (data.data() != null) {
      return UserModel.fromJson(data.data()!);
    }
  }
}