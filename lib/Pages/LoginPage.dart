import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return FlutterLogin(
      hideForgotPasswordButton: true,
      title: 'Tweter',
      logo: 'assets/bird.png',
      onLogin: (LoginData data) {
        return Future.value("todo");
      },
      onSignup: (LoginData data) {
        return Future<String>.delayed(Duration(seconds: 2), () => "hello");
      },
      onRecoverPassword: (String) => Future.value("NO"),
    );
  }
}
