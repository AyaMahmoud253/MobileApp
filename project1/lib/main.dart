import 'package:flutter/material.dart';
import 'package:project1/screens/edit_profile_screen.dart';
import 'package:project1/screens/login_screen.dart';
import 'package:project1/screens/profile_screen.dart';
import 'package:project1/screens/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'LoginPage': (context) => LoginPage(),
        'ProfilePage': (context) => ProfilePage(),
        //'EditProfilePage': (context) => EditProfilePage(),
        'SignUpPage': (context) => SignUpPage(),
      },
      home: SignUpPage(), // Remove initialRoute and set home to SignUpPage
    );
  }
}
