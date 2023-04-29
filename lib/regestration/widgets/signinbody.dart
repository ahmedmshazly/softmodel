import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:softmodel/regestration/screens/signupscreen.dart';
import 'package:softmodel/regestration/widgets/regestrationbutton.dart';
import 'package:softmodel/regestration/widgets/textfield.dart';

import '../../home/screens/homescreen.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'lib/regestration/assets/images/logoAlonev1.png',
              width: 100,
            ),
          ),
        ),
        const Spacer(),
        const Text(
          "LogIn",
          style: TextStyle(
            color: Color(0xff072f53),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * .50,
          width: MediaQuery.of(context).size.width * .90,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 15.0, // soften the shadow
                spreadRadius: 2.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextInput(
                  text: "Email Address",
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              RegestrationButton(
                height: MediaQuery.of(context).size.height * .07,
                width: MediaQuery.of(context).size.width * .8,
                radius: 15,
                bg: const Color(0xff072f53),
                stroke: const Color(0xffffffff),
                text: "LogIn",
                textcolor: const Color(0xffffffff),
                page: HomeScreen(),
              ), // TODO: Log in implement

              const SizedBox(height: 16),
              RegestrationButton(
                height: MediaQuery.of(context).size.height * .07,
                width: MediaQuery.of(context).size.width * .8,
                radius: 15,
                bg: const Color(0xffffffff),
                stroke: const Color(0xff072f53),
                text: "SignUp",
                textcolor: const Color(0xff072f53),
                page: const SignupScreen(),
              ),
              const Spacer()
            ],
          ),
        ),
        const Spacer()
      ],
    ));
  }
}
