import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profilesample/login/login_model.dart';
import 'package:profilesample/signup/signup_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: const Text(
              'ログイン',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Consumer<LoginModel>(
            builder: (context, model, child) {
              return Center(
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'メールアドレス',
                            ),
                            controller: _mailController,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (text) {
                              model.mail = text;
                              model.isCheckEnabledLogin();
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'パスワード',
                          ),
                          obscureText: true,
                          controller: _passwordController,
                          onChanged: (text) {
                            model.password = text;
                            model.isCheckEnabledLogin();
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: loginButton(model, _mailController,
                              _passwordController, context),
                        ),
                        Container(
                          child: CupertinoButton(
                            child: const Text(
                              '新規登録',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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

  CupertinoButton loginButton(
      LoginModel model,
      TextEditingController mailController,
      TextEditingController passwordController,
      BuildContext context) {
    return CupertinoButton(
      child: const Text(
        'ログイン',
      ),
      onPressed: model.isEnabledLogin
          ? () async {
              model.mail = mailController.text;
              model.password = passwordController.text;
              await model.login(context);
            }
          : null,
    );
  }
}
