import 'package:flutter/material.dart';

class DropdownQuestion extends StatefulWidget {
  final List<String> options;
  final ValueNotifier<String?> selectedValue;

  DropdownQuestion({required this.options, required this.selectedValue});

  @override
  _DropdownQuestionState createState() => _DropdownQuestionState();
}

class _DropdownQuestionState extends State<DropdownQuestion> {
  @override
  void initState() {
    super.initState();
    // Set the initial value of the dropdown
    widget.selectedValue.value = widget.options[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedValue.value,
      onChanged: (String? newValue) {
        setState(() {
          widget.selectedValue.value = newValue!;
        });
      },
      items: widget.options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
