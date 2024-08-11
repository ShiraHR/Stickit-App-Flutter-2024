import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode? focusNode;

  const InputTextField({super.key, 
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            hintText,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 98, 247, 172),
                  blurRadius: 5,
                  spreadRadius: 5,
                ),
              ],
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              autocorrect: true,
              controller: controller,
              obscureText: obscureText,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 98, 247, 172),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
