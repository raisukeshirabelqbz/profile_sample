import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profilesample/profile/profile_page.dart';
import 'package:profilesample/profile/profile_photo.dart';
import 'package:profilesample/signup/signup_model.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: const Text(
              '新規登録',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          body: Consumer<SignUpModel>(
            builder: (context, model, child) {
              return Center(
                child: SingleChildScrollView(
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ProfilePhoto(),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'メール',
                            ),
                            controller: mailController,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (text) {
                              model.email = text;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'パスワード',
                            ),
                            controller: passwordController,
                            obscureText: true,
                            onChanged: (text) {
                              model.password = text;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'ユーザー名',
                            ),
                            controller: nameController,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (text) {
                              model.name = text;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CupertinoButton(
                            child: const Text('登録'),
                            onPressed: () async {
                              try {
                                await model.signUp();
                                _showDialog(context);
                              } catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      title: Text(
                                        e.toString(),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('登録しました'),
          actions: <Widget>[
            FlatButton(
              child: const Text('OK'),
              onPressed: () {
                mailController.clear();
                passwordController.clear();
                nameController.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
