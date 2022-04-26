// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsappv2mobile/home_screen.dart';
import 'package:newsappv2mobile/loginpage.dart';

class loginaid extends StatelessWidget {
  const loginaid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text("une erreur s'est produite"));
              }
              else if (snapshot.hasData) {
                return const HomeScreen();
              } else {
                return const Login();
              }
            }),
      );
}
