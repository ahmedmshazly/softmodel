import 'package:flutter/material.dart';

class IntegerInputQuestion extends StatefulWidget {
  final ValueNotifier<int?> intValue;
  final void Function(int) onSubmitted;

  IntegerInputQuestion({required this.intValue, required this.onSubmitted});

  @override
  _IntegerInputQuestionState createState() => _IntegerInputQuestionState();
}

class _IntegerInputQuestionState extends State<IntegerInputQuestion> {
  final TextEditingController _controller = TextEditingController();

  void onFieldChanged(String value) {
    int? intValue = int.tryParse(value);
    if (intValue != null) {
      widget.intValue.value = intValue; // Update the ValueNotifier
    } else {
      widget.intValue.value = null; // Update the ValueNotifier to null if the input is not valid
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      onChanged: (value) => onFieldChanged(value),
      onSubmitted: (value) => widget.onSubmitted(widget.intValue.value!),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter an integer',
      ),
    );
  }
}
