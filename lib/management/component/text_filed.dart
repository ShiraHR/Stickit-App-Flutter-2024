import 'package:flutter/material.dart';

// A stateless widget that creates a text input field with a hint text.

class GenericTextInput extends StatelessWidget {
  final String hintText; // Hint text for the input field.
  final TextEditingController controller; // Controller to manage the input text.
  final void Function(String)? onChanged; // Callback function when the text changes.

  // Constructor to initialize the hintText, controller, and onChanged.
  GenericTextInput({
    required this.hintText,
    required this.controller,
    this.onChanged, // Initialize onChanged in the constructor.
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Sets the controller for the TextField.
      decoration: InputDecoration(
        labelText: hintText, // Sets the hint text for the TextField.
      ),
      onChanged: onChanged, // Sets the onChanged callback.
    );
  }
}
