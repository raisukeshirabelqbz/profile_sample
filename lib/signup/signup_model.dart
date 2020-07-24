import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  String email = '';
  String password = '';
  String uid = '';
  String name = '';
  String photoUrl = '';

  Future signUp() async {
    if (email.isEmpty) {
      throw ('メールアドレスを入力してください');
    }
    if (password.isEmpty) {
      throw ('パスワードを入力してください');
    }
    final FirebaseUser user =
        (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
            .user;
    //表示名はcreateUserWithEmailAndPasswordで作成できないためUserUpdateInfoで上書きする
    final userUpdateInfo = UserUpdateInfo();
    //ここでテキストフィールドの値を追加する
    userUpdateInfo.displayName = name;
    //Authとfire storeに書き込む為、一度変数に代入
    photoUrl = 'profileImages/${user.uid}';
    userUpdateInfo.photoUrl = photoUrl;
    //ユーザー情報アップデート
    await user.updateProfile(userUpdateInfo);
    await user.reload();

    this.uid = user.uid;
    Firestore.instance.collection("users").document(uid).setData({
      'email': email,
      'uid': uid,
      'name': name,
      'photoUrl': photoUrl,
    });
  }
}
