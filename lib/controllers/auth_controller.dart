import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:parley/models/user_model.dart';
import 'package:parley/screens/auth/login_view.dart';
import 'package:parley/services/firestore_service.dart';
import 'package:parley/services/session_service.dart';

class AuthController with ChangeNotifier {
  static final AuthController _instance = AuthController._internal();
  factory AuthController() => _instance;
  AuthController._internal();

  UserModel? userData;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future checkAuth() async {
    Map<String, dynamic>? data = SessionService().getUserInfoSession();
    if (data != null) {
      userData = UserModel.fromJson(data);
    }
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        if (userData != null) {
          SessionService().clearAll();
          Get.offAll(const LoginView());
        }
      } else {

      }
    });
  }

  Future<bool> login(String email, String password) async {
    EasyLoading.show();
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      String uid = credential.user!.uid;
      userData = await FirestoreService().getUser(uid);
      EasyLoading.dismiss();
      if (userData == null) {
        EasyLoading.showError('No user found for that email.');
        logout();
        return false;
      }
      SessionService().saveUserInfo(userData!.toJson());
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        EasyLoading.dismiss();
        EasyLoading.showError('Invalid credential.');
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Something went wrong.');
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Something went wrong.');
    }
    return false;
  }

  Future<bool> signUp({
   required String username,
   required String email,
   required String password,
  }) async {
    EasyLoading.show();
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      String uid = userCredential.user!.uid;
      userData = UserModel(
        uid: uid,
        username: username,
        email: email,
        createdAt: DateTime.now().millisecondsSinceEpoch
      );
      SessionService().saveUserInfo(userData!.toJson());
      await FirestoreService().setUser(userData!);
      EasyLoading.dismiss();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        EasyLoading.showError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        EasyLoading.showError('The account already exists for that email.');
      } else {
        EasyLoading.showError('Something went wrong.');
      }
    } catch (e) {
      EasyLoading.showError('Something went wrong.');
    }
    EasyLoading.dismiss();
    return false;
  }

  Future logout() async {
    auth.signOut();
  }
}