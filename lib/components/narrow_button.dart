import 'package:flutter/material.dart';

class NarrowButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final String color;
  final String? imagePath;

  const NarrowButton({super.key, 
    required this.text,
    required this.onTap,
    this.color = "green",
    this.imagePath,
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
        width: screenWidth * 0.42, 
        height: 56,
        decoration: BoxDecoration(
          gradient: color == "green" ? greenGradient : yellowGradient,
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(vertical: 17),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (imagePath != null) ...[
                const SizedBox(width: 8), 
                Image.asset(
                  imagePath!,
                  width: 24,
                  height: 24,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
