import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:tweter/Singleton.dart';
import 'package:tweter/data/DataFetchers.dart';

class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return FlutterLogin(
      hideForgotPasswordButton: true,
      title: 'Tweter',
      logo: 'assets/bird.png',
      emailValidator: (_) => null,
      messages: LoginMessages(usernameHint: "Username"),
      onLogin: (LoginData data) async {
        bool logWork = await authenticate(data.name, data.password);
        if (logWork) Navigator.pushNamed(context, Singleton.timeLineRoute);

        return "Failed to log in";
      },
      onSignup: (LoginData data) async{
        bool logWork = await addUser(data.name, data.password);
        if (logWork) Navigator.pushNamed(context, Singleton.timeLineRoute);

        return "Failed to sign up";
      },
      onRecoverPassword: null,
    );
  }
}
