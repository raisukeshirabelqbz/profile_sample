import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhotoModel extends ChangeNotifier {
  String uid = '';
  String photoUrl;

  Future uploadPhotoFromDevice(ImageSource imageSource, String uid) async {
    File photoFile;
    final pickedPhoto = await ImagePicker().getImage(
      source: imageSource,
    );
    //もし画像を選択せずキャンセルされたらreturn;
    if (pickedPhoto == null) return;
    photoFile = File(pickedPhoto.path);
    //UIDごとに画像をcloud storageに保存する
    StorageReference reference =
        FirebaseStorage.instance.ref().child("images/");
    StorageUploadTask uploadTask = reference.putFile(photoFile);
    final downloadUrl =
        await (await uploadTask.onComplete).ref.getDownloadURL();
    photoUrl = downloadUrl.toString();
    notifyListeners();
  }
}
