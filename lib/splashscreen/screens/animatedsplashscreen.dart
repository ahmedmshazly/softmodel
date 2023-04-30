import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:softmodel/home/screens/homescreen.dart';
import 'package:softmodel/onboarding/screens/onboardingscreen.dart';
import 'package:softmodel/onboarding/widgets/onboardingbody.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import '../../firebase_options.dart';
import '../../notification_manager.dart';
import '../widgets/animatedlogo.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';

class AnimatedSplash extends StatefulWidget {
  final int duration, bgcolor;
  final double iconsize;
  const AnimatedSplash(
      {Key? key,
      required this.iconsize,
      required this.duration,
      required this.bgcolor})
      : super(key: key);

  @override
  _AnimatedSplashState createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash> {
  late Future<void> _welcomeNotificationFuture;

  @override
  void initState() {
    super.initState();
    _welcomeNotificationFuture = NotificationManager().showWelcomeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _welcomeNotificationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: AnimatedSplashScreen(
              splash: Center(
                  child: AnimatedLogo(
                      duration: 2,
                      height: 125,
                      width: 125,
                      padding: 8.0,
                      curveType: Curves.decelerate,
                      imageWidget:
                          r'lib\splashscreen\assets\images\Logobluevert.png')),
              splashIconSize: widget.iconsize,
              duration: widget.duration,
              backgroundColor: Color(widget.bgcolor),
              splashTransition: SplashTransition.fadeTransition,
              pageTransitionType: PageTransitionType.fade,
              nextScreen: FutureBuilder(
                future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        return HomeScreen();
                      } else {
                        return const OnBoardingScreen();
                      }
                    default:
                      return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
