import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profilesample/profile/profile_photo_model.dart';
import 'package:provider/provider.dart';

class ProfilePhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfilePhotoModel>(
      create: (_) => ProfilePhotoModel()..getPhotoUrl(),
      child: Consumer<ProfilePhotoModel>(
        builder: (context, model, child) {
          return FlatButton(
            shape: const CircleBorder(
              side: BorderSide(
                color: Colors.black,
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
            child: model.photoUrl == null
                ? Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 90,
                    ),
                  )
                : CircleAvatar(
                    radius: 70.0,
                    backgroundImage: NetworkImage(model.photoUrl),
                  ),
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoActionSheet(
                    title: const Text('写真を選択してください'),
                    actions: <Widget>[
                      CupertinoActionSheetAction(
                        child: const Text('カメラ'),
                        onPressed: () {
                          model.uploadPhotoFromDevice(
                            ImageSource.camera,
                            model.uid,
                          );
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: const Text('ライブラリ'),
                        onPressed: () {
                          model.uploadPhotoFromDevice(
                            ImageSource.gallery,
                            model.uid,
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      child: const Text('キャンセル'),
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
