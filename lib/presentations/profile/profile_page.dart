import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profilesample/presentations/profile/profile_model.dart';
import 'package:profilesample/presentations/profile_photo/profile_photo.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileModel>(
      create: (_) => ProfileModel()..getCurrentUser(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            'プロフィール',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Consumer<ProfileModel>(
          builder: (context, model, child) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ProfilePhoto(),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    title: Container(
                      child: Text(
                        model.name,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
