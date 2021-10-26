import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';

class GithubSignInScreen extends StatefulWidget {
  GithubSignInScreen({Key? key}) : super(key: key);

  @override
  _GithubSignInScreenState createState() => _GithubSignInScreenState();
}

class _GithubSignInScreenState extends State<GithubSignInScreen> {
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
                      await service.signInWithGitHub(context);
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
                    "Sign In with Github",
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
  Future<UserCredential> signInWithGitHub(context) async {
    // Create a GitHubSignIn instance
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: "c39e81d538fd1b5ccff6",
        clientSecret: "51d2435200f361689228fd023d7e7ec4f2b7a09d",
        redirectUrl:
            'https://emailsigninauthdemo.firebaseapp.com/__/auth/handler');

// print("result is ${gitHubSignIn.} ${result.token}");

    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);
    // Create a credential from the access token
    final githubAuthCredential = GithubAuthProvider.credential(result.token!);
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(githubAuthCredential);
  }

  Future<void> signOutWithFacebook(context) async {
    await FirebaseAuth.instance.signOut();
    const snackBar = SnackBar(
        content:
            Text('User Signed out with facebook. Click on login to login now'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
