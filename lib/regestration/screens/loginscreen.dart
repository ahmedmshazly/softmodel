import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../firebase_options.dart';
import '../widgets/regestrationbutton.dart';
import 'dart:developer' as dev;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  late Future<FirebaseApp> _initialization;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _initialization = Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Loged in successfully!'),
        duration: const Duration(seconds: 3),
        backgroundColor: const Color(0xff4caf50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  void _showErrorSnackbar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
        backgroundColor: const Color(0xffd32f2f),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 16,
          backgroundColor: Colors.transparent,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xff072f53),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: FutureBuilder(
        future: _initialization,
        builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.connectionState == ConnectionState.waiting) {
              _showLoadingDialog(context);
            } else if (snapshot.connectionState == ConnectionState.done) {
              // Check if there is at least one route in the stack
              if (Navigator.of(context).canPop()) {
                Navigator.pop(context); // Close the loading dialog
              }
            }
          });

          return Scaffold(body: Builder(
            builder: (BuildContext scaffoldContext) {
              return Container(
                  constraints: const BoxConstraints.expand(),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          r"lib\regestration\assets\images\regscreen2.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Image.asset(
                                'lib/regestration/assets/images/logoAlonev1.png',
                                width: 100,
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1),
                            const Center(
                              child: Text(
                                "LogIn",
                                style: TextStyle(
                                  color: Color(0xff072f53),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 24),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _email,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Email Address',
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      controller: _password,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Password',
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    RegestrationButton(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .07,
                                      width: MediaQuery.of(context).size.width *
                                          .8,
                                      radius: 15,
                                      bg: const Color(0xff072f53),
                                      stroke: const Color(0xffffffff),
                                      text: "LogIn",
                                      textcolor: const Color(0xffffffff),
                                      func: () async {
                                        final email = _email.text;
                                        final password = _password.text;
                                        try {
                                          final credential = await FirebaseAuth
                                              .instance
                                              .signInWithEmailAndPassword(
                                                  email: email,
                                                  password: password);
                                          _showSuccessSnackbar();
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/home',
                                              (route) => false);
                                        } on FirebaseAuthException catch (e) {
                                          String errorMessage;

                                          if (e.code == 'weak-password') {
                                            errorMessage =
                                                'Firebase: The password you provided is weak';
                                          } else if (e.code ==
                                              'email-already-in-use') {
                                            errorMessage =
                                                'Firebase: The account already exists for that email';
                                          } else {
                                            errorMessage =
                                                'Firebase: An unknown error occurred';
                                          }

                                          // Show snackbar for Firebase exception
                                          _showErrorSnackbar(errorMessage);
                                        } catch (e, s) {
                                          dev.log('Error: $e',
                                              name: 'SignUp',
                                              level: 1000,
                                              error: e,
                                              stackTrace: s);
                                          _showErrorSnackbar(
                                              'Something went wrong');
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    RegestrationButton(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .07,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .8,
                                        radius: 15,
                                        bg: const Color(0xffffffff),
                                        stroke: const Color(0xff072f53),
                                        text: "SignUp",
                                        textcolor: const Color(0xff072f53),
                                        func: () {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context, '/up', (route) => false);
                                        }),
                                    const SizedBox(height: 16),
                                    TextButton(
                                      onPressed: () {
                                        // TODO: Implement forgot password functionality
                                      },
                                      child: const Text(
                                        "Forgot your password?",
                                        style: TextStyle(
                                          color: Color(0xff072f53),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            },
          ));
        },
      ),
    );
  }
}
