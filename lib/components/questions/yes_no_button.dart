import 'package:flutter/material.dart';

class YesNoButton extends StatelessWidget {
  final String text;
  final bool isTapped;
  final bool isCorrect; // Indicates if this button is correct
  final VoidCallback onTap;

  YesNoButton({
    required this.text,
    required this.isTapped,
    required this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final LinearGradient greenGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Theme.of(context).colorScheme.onPrimary,
        Theme.of(context).colorScheme.primary,
      ],
    );

    final LinearGradient redGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Theme.of(context).colorScheme.onError,
        Theme.of(context).colorScheme.error,
      ],
    );

    const LinearGradient whiteGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.white, Colors.white],
    );

    final LinearGradient buttonColor = isTapped
        ? (isCorrect ? greenGradient : redGradient)
        : whiteGradient;

    final IconData icon = isTapped
        ? (isCorrect ? Icons.check : Icons.close)
        : Icons.help_outline;

    final Color textColor = isTapped ? Colors.white : Colors.black;

    final List<BoxShadow> boxShadow = isTapped
        ? []
        : [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.36,
        height: 56,
        decoration: BoxDecoration(
          gradient: buttonColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: boxShadow,
        ),
        padding: const EdgeInsets.symmetric(vertical: 17),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (isTapped)
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Icon(
                    icon,
                    color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}