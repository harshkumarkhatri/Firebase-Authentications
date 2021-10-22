// ignore_for_file: file_names

// import 'package:email_authentication_firebase_flutter/authentication.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   String? _email, _password;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         LoginScreenBar: LoginScreenBar(
//           title: const Text("Login"),
//         ),
//         body: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),
//                 Container(
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.only(
//                       top: 25, right: 10, bottom: 10, left: 10),
//                   child: TextFormField(
//                     validator: (input) {
//                       if (input!.isEmpty) {
//                         return "Please enter an email";
//                       }
//                     },
//                     onSaved: (input) => _email = input,
//                     decoration: const InputDecoration(
//                         labelText: "Email", icon: Icon(Icons.account_circle)),
//                   ),
//                 ),
//                 Container(
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.only(
//                       top: 25, right: 10, bottom: 10, left: 10),
//                   child: TextFormField(
//                     validator: (input) {
//                       print(input!.isEmpty);
//                       if (input.length < 6) {
//                         return "Please enter 6 char or more";
//                       }
//                     },
//                     onSaved: (input) => _password = input,
//                     decoration: const InputDecoration(
//                         labelText: "Password", icon: Icon(Icons.lock)),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(15),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       AuthenticationHelper()
//                           .signIn(email: _email!, password: _password!);
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(18),
//                       ),
//                       padding: const EdgeInsets.all(10),
//                       child: const Text(
//                         "Submit",
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: const [
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(10),
//                       child: Text("Forgot Password",
//                           style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 13,
//                               fontWeight: FontWeight.bold)),
//                     ),
//                   ],
//                 ),

//                 // Row(
//                 //   children: [Padding(padding: EdgeInsets.all(20)),
//                 //   Column(
//                 //     children: [
//                 //       Text("Hello user")
//                 //     ],
//                 //   )
//                 //   ],
//                 // )
//               ],
//             ),
//           ),
//         ));
//   }
// }

// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  String? userName;
  @override
  Widget build(BuildContext context) {
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
                        .signInWithEmailAndPassword(
                            email: usernameController.text.toString(),
                            password: passwordController.text.toString());
                    final snackBar = SnackBar(content: Text('Loggin in now'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    setState(() {
                      userName = userCredential.user!.email;
                    });
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
                child: const Text("Login"),
              ),
              Text("User email is $userName")
            ],
          ),
        ),
      ),
    );
  }
}
