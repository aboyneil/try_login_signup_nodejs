import 'package:flutter/material.dart';
import 'package:try_login_signup_nodejs/screens/login.dart';
import 'package:try_login_signup_nodejs/screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Account Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => Login(),
        '/sign-up': (context) => SignUp(),
      },
    );
  }
}
