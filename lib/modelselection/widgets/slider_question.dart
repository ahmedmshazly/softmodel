import 'package:flutter/material.dart';

class SliderQuestion extends StatefulWidget {
  final double min;
  final double max;
  final void Function(double) onChanged;

  SliderQuestion(
      {required this.min, required this.max, required this.onChanged});

  @override
  _SliderQuestionState createState() => _SliderQuestionState();
}

class _SliderQuestionState extends State<SliderQuestion> {
  double _currentValue;

  _SliderQuestionState() : _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.min;
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentValue,
      onChanged: (newValue) {
        setState(() {
          _currentValue = newValue;
        });
        widget.onChanged(newValue);
      },
      min: widget.min,
      max: widget.max,
      activeColor: const Color(0xfffbc108), // Add active color
      inactiveColor: const Color(0xffc9d1d8), // Add inactive color
      label: _currentValue.toStringAsFixed(1), // Add label
    );
  }
}

// Slider(
//       value: _currentValue,
//       onChanged: (newValue) {
//         setState(() {
//           _currentValue = newValue;
//         });
//         widget.onChanged(newValue);
//       },
//       min: widget.min,
//       max: widget.max,
//     );