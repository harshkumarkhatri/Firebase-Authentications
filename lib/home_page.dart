// ignore_for_file: file_names

import 'package:email_authentication_firebase_flutter/facebook_sign_in.dart';
import 'package:email_authentication_firebase_flutter/github_screen.dart';
import 'package:email_authentication_firebase_flutter/google_sign_in.dart';
import 'package:email_authentication_firebase_flutter/login_screen.dart';
import 'package:email_authentication_firebase_flutter/sign_out_screen.dart';
import 'package:email_authentication_firebase_flutter/sign_up_screen.dart';
import 'package:email_authentication_firebase_flutter/twitter_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
                onSurface: Colors.grey,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
              child: const Text(
                "Login",
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
                onSurface: Colors.grey,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()));
              },
              child: const Text(
                "SingUp",
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
                onSurface: Colors.grey,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SignOut()));
              },
              child: const Text(
                "Sign Out",
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
                onSurface: Colors.grey,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => GoogleSignInScreen()));
              },
              child: const Text(
                "Google Sign In",
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
                onSurface: Colors.grey,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => FacebookSignInScreen()));
              },
              child: const Text(
                "Facebook Sign In",
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
                onSurface: Colors.grey,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => GithubSignInScreen()));
              },
              child: const Text(
                "Github Sign In",
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
                onSurface: Colors.grey,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => TwitterSignInScreen()));
              },
              child: const Text(
                "Twitter Sign In",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
