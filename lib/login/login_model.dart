import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profilesample/profile/profile_page.dart';

class LoginModel extends ChangeNotifier {
  String mail = '';
  String password = '';

  bool isEnabledLogin = false;

  Future login(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mail,
        password: password,
      );
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ),
      );
    } catch (e) {
      _showDialog(context, e.toString());
    }
  }

  Future _showDialog(
    BuildContext context,
    String title,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
        );
      },
    );
  }

  void isCheckEnabledLogin() {
    //大文字小文字数字の8桁以上
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    if (mail.length >= 1 && RegExp(pattern).hasMatch(password)) {
      isEnabledLogin = true;
    } else {
      isEnabledLogin = false;
    }
    notifyListeners();
  }
}
