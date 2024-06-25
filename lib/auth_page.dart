import 'package:coffee_card/login_or_register_page.dart';
import 'package:coffee_card/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //User is loggen in
          if (snapshot.hasData) {
            return HomePage();
          }

          //User is NOT signed in
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
