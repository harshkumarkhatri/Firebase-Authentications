import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FacebookSignInScreen extends StatefulWidget {
  FacebookSignInScreen({Key? key}) : super(key: key);

  @override
  _FacebookSignInScreenState createState() => _FacebookSignInScreenState();
}

class _FacebookSignInScreenState extends State<FacebookSignInScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    FirebaseService service = FirebaseService();
                    try {
                      await service.signInWithFacebook(context);
                    } catch (e) {
                      if (e is FirebaseAuthException) {
                        showMessage(e.message!);
                      }
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: const Text(
                    "Sign In with Facebook",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
        : Container(child: Center(child: CircularProgressIndicator()));
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}

class FirebaseService {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Future<String?> signInwithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount!.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //     await _auth.signInWithCredential(credential);
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //     throw e;
  //   }
  // }

  // Future<void> signOutFromGoogle() async {
  //   await _googleSignIn.signOut();
  //   await _auth.signOut();
  // }

  Future<UserCredential> signInWithFacebook(context) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    print("Oauth creds are ${loginResult.status}");
    final snackBar = const SnackBar(
        content:
            Text('User Signedin with facebook. Click on login to login now'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<void> signOutWithFacebook(context) async {
    await FacebookAuth.instance.logOut();
    print("User logged out from facebook");
    final snackBar = const SnackBar(
        content:
            Text('User Signed out with facebook. Click on login to login now'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
