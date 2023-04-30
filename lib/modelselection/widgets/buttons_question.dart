import 'package:flutter/material.dart';

class ButtonsQuestion extends StatelessWidget {
  final List<String> options;
  final void Function(String) onSelected;

  ButtonsQuestion({required this.options, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
  children: options.map((option) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: ElevatedButton(
            onPressed: () => onSelected(option),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff072f53),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16),
            ),
            child: Text(option),
          ),
        ),
        SizedBox(height: 16), // Add SizedBox between each button
      ],
    );
  }).toList(),
);  }
}
