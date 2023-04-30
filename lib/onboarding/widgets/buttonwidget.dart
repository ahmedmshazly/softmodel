import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:softmodel/regestration/screens/loginscreen.dart';
import 'package:softmodel/regestration/screens/regestrationscreen.dart';
import 'package:softmodel/regestration/screens/signupscreen.dart';

class OnboardingButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final PageController pageController;
  final int index;

  const OnboardingButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.pageController,
      required this.index});

  @override
  State<OnboardingButton> createState() => _OnboardingButtonState();
}

class _OnboardingButtonState extends State<OnboardingButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton.extended(
          onPressed: () {
            widget.index == 2
                ? Navigator.pushNamedAndRemoveUntil(context, '/log', (route) => false)
                : widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.ease);
          },
          label: Text(widget.label),
          icon: Icon(widget.icon),
          backgroundColor: const Color(0xff072f54),
        )
      ],
    );
  }
}
