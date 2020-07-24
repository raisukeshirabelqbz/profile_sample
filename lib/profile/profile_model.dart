import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileModel extends ChangeNotifier {
  String name = '';
  String uid = '';
  String photoUrl = '';

  Future getCurrentUser() async {
    try {
      final currentUser = await FirebaseAuth.instance.currentUser();
      name = currentUser.displayName;
      uid = currentUser.uid;
      photoUrl = currentUser.photoUrl;
      //UIDを端末に保存する
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', uid);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
