import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final String color;

  const WideButton({super.key, 
    required this.text,
    required this.onTap,
    this.color = "green",
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    const LinearGradient greenGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF31F091), Color(0xFF08C667)],
    );

    const LinearGradient yellowGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFFFDD7A), Color(0xFFEDB524)],
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.9,
        height: 56,
        decoration: BoxDecoration(
          gradient: color == "green" ? greenGradient : yellowGradient,
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(vertical: 17),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

