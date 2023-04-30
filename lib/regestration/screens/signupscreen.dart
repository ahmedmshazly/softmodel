import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../firebase_options.dart';
import '../widgets/regestrationbutton.dart';
import 'loginscreen.dart';
import 'dart:developer' as dev;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _name;
  final _formKey = GlobalKey<FormState>();
  late Future<FirebaseApp> _initialization;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
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
        content: const Text('Signed up successfully!'),
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
            child: Center(
              child: Column(
                children: const [
                  Text('Loading'),
                  CircularProgressIndicator(
                    color: Color(0xff072f53),
                  ),
                ],
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
              if (snapshot.hasError) {
                _showErrorSnackbar("${snapshot.hasError}");
              }
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
                              height: MediaQuery.of(context).size.height * 0.1),
                          const Center(
                            child: Text(
                              "SignUp",
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
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: _name,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your full name';
                                            }
                                            return null;
                                          },
                                          enableSuggestions: false,
                                          autocorrect: false,
                                          keyboardType: TextInputType.name,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Full Name',
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter an email address';
                                            } else if (!RegExp(
                                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                                .hasMatch(value)) {
                                              return 'Please enter a valid email address';
                                            }
                                            return null;
                                          },
                                          enableSuggestions: false,
                                          autocorrect: false,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: _email,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Email Address',
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter a password';
                                            } else if (value.length < 6) {
                                              return 'Password must be at least 6 characters long';
                                            }
                                            return null;
                                          },
                                          obscureText: true,
                                          enableSuggestions: false,
                                          autocorrect: false,
                                          controller: _password,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Password',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  RegestrationButton(
                                    height: MediaQuery.of(context).size.height *
                                        .07,
                                    width:
                                        MediaQuery.of(context).size.width * .8,
                                    radius: 15,
                                    bg: const Color(0xff072f53),
                                    stroke: const Color(0xffffffff),
                                    text: "SignUp",
                                    textcolor: const Color(0xffffffff),
                                    func: () async {
                                      final email = _email.text;
                                      final password = _password.text;
                                      try {
                                        if (!_formKey.currentState!
                                            .validate()) {
                                          return;
                                        }
                                        final credential = await FirebaseAuth
                                            .instance
                                            .createUserWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                        );
                                        _email.clear();
                                        _password.clear();
                                        _name.clear();
                                        _showSuccessSnackbar();
                                        // sleep(const Duration(seconds: 3));
                                        // Navigate to LogInScreen and show snackbar for successful sign up
                                        // ignore: use_build_context_synchronously
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()),
                                        );
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
                                      } catch (e, s) {
                                        dev.log('Error: $e',
                                            name: 'SignUp',
                                            level: 1000,
                                            error: e,
                                            stackTrace: s);
                                      }
                                    },
                                  ),
                                  RegestrationButton(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .07,
                                      width: MediaQuery.of(context).size.width *
                                          .8,
                                      radius: 15,
                                      bg: const Color(0xffffffff),
                                      stroke: const Color(0xff072f53),
                                      text: "LogIn",
                                      textcolor: const Color(0xff072f53),
                                      func: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()),
                                          (route) => false,
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ));
        },
      ),
    );
  }
}
