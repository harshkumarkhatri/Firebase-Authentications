import 'package:email_authentication_firebase_flutter/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _initialized = false;
  bool _error = false;

  void flutterfirebasefire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    flutterfirebasefire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return errorHandle();
    }

    if (!_initialized) {
      return progressHandle();
    }

    var usernameController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
            ),
            TextField(
              controller: passwordController,
            ),
            TextButton(
              onPressed: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: usernameController.text.toString(),
                          password: passwordController.text.toString());
                  final snackBar = const SnackBar(
                      content:
                          Text('User Signed up. Click on login to login now'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print("inside $e");
                }
              },
              child: Text("Sign-Up"),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                },
                child: Text("Login"))
          ],
        ),
      ),
    ));
  }
}

Widget errorHandle() {
  return Text("There is an error");
}

Widget progressHandle() {
  return Text("This is a progress bar section");
}
