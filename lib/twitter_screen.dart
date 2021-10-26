import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

class TwitterSignInScreen extends StatefulWidget {
  TwitterSignInScreen({Key? key}) : super(key: key);

  @override
  _TwitterSignInScreenState createState() => _TwitterSignInScreenState();
}

class _TwitterSignInScreenState extends State<TwitterSignInScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   width: 80,
              //   height: 60,
              //   child: ElevatedButton(
              //     onPressed: () async {
              //       setState(() {
              //         isLoading = true;
              //       });
              //       FirebaseService service = FirebaseService();
              //       try {
              //         await service.signInWithGitHub(context);
              //       } catch (e) {
              //         if (e is FirebaseAuthException) {
              //           showMessage(e.message!);
              //         }
              //       }
              //       setState(() {
              //         isLoading = false;
              //       });
              //     },
              //     child: const Text(
              //       "Sign In with Github",
              //       style: TextStyle(
              //           color: Colors.black, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              Center(
                child: ElevatedButton(
                    child: Text(
                      'Login With Twitter',
                      style: TextStyle(color: Colors.yellow),
                    ),
                    onPressed: () async {
                      print(0);
                      final twitterLogin = TwitterLogin(
                        // Consumer API keys
                        apiKey: 'DB6JngNgXTTEAn2hIOvEuGTFp',
                        // Consumer API Secret keys
                        apiSecretKey:
                            'OC3gSdMc3mrXDYECV276u7U4f9OjMu67caqX1kIVb2s94FeOGb',
                        // Registered Callback URLs in TwitterApp
                        // Android is a deeplink
                        // iOS is a URLScheme
                        redirectURI:
                            'https://emailsigninauthdemo.firebaseapp.com/__/auth/handler',
                      );
                      print(1);

                      final authResult = await twitterLogin.login();
                      print(2);

                      //      await FirebaseAuth.instance
                      // .signInWithCredential(value.authToken);
                      final AuthCredential credential =
                          TwitterAuthProvider.credential(
                              accessToken: authResult.authToken!,
                              secret: authResult.authTokenSecret!);
                      await FirebaseAuth.instance
                          .signInWithCredential(credential);

                      print(3);

                      // authResult.then(
                      //   (value) {
                      //     if (value.status == TwitterLoginStatus.loggedIn) {
                      //       print("It is a success");
                      //     } else if (value.status ==
                      //         TwitterLoginStatus.cancelledByUser) {
                      //       print("User cancelled it");
                      //     } else if (value.status == TwitterLoginStatus.error) {
                      //       print("It is a error");
                      //     }
                      //     // switch (authResult.status) {
                      //     //   case TwitterLoginStatus.loggedIn:
                      //     //     // success
                      //     //     break;
                      //     //   case TwitterLoginStatus.cancelledByUser:
                      //     //     // cancel
                      //     //     break;
                      //     //   case TwitterLoginStatus.error:
                      //     //     // error
                      //     //     break;
                      //     // }
                      //   },
                      // );
                    }),
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
