import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignOut extends StatefulWidget {
  const SignOut({Key? key}) : super(key: key);

  @override
  _SignOutState createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                var user = await FirebaseAuth.instance.currentUser;
                print("User is $user");
              },
              child: Text(
                "Check User",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: Text(
                "Sign Out",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
