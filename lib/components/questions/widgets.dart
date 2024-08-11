import 'package:flutter/material.dart';

Widget questionInstructions(BuildContext context, String questionInstructions) {
  final double screenWidth = MediaQuery.of(context).size.width;
  return Container(
    width: screenWidth * 0.8,
    height: 40,
    // padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Theme.of(context).colorScheme.secondary,
    ),
    child: Center(
      child: Text(questionInstructions,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
    ),
  );
}

Widget ImageAndQuestion(String image, String question, double height) {
  return Container(
    height: height,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color:
                Colors.black.withOpacity(0.5), // Semi-transparent black color
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "?",
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                question,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center, // Center the text horizontally
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
