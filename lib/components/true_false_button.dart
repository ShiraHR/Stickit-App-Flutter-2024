import 'package:flutter/material.dart';

class TrueOrFalseButton extends StatefulWidget {
  final bool isTrue;
  final void Function()? onTap;

  const TrueOrFalseButton({
    super.key, 
    required this.isTrue,
    required this.onTap,
  });

  @override
  _TrueOrFalseButtonState createState() => _TrueOrFalseButtonState();
}

class _TrueOrFalseButtonState extends State<TrueOrFalseButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    const LinearGradient greenGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF31F091), Color(0xFF08C667)],
    );

    final BoxDecoration decoration = BoxDecoration(
      color: isPressed ? null : Colors.white,
      gradient: isPressed ? greenGradient : null,
      border: Border.all(
        color: const Color(0xFFDBE8DE),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(50),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000), // 20% opacity
          offset: Offset(0, 1.14),
          blurRadius: 9.6,
          spreadRadius: -2.86,
        ),
        BoxShadow(
          color: Color(0x1A000000), // 10% opacity
          offset: Offset(0, 4),
          blurRadius: 6,
          spreadRadius: -2.86,
        ),
      ],
    );

    return GestureDetector(
      onTap: () {
        setState(() {
          isPressed = !isPressed;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Container(
        width: screenWidth * 0.415,
        height: 56,
        decoration: decoration,
        padding: const EdgeInsets.symmetric(vertical: 17),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.isTrue ? 'נכון' : 'לא נכון',
                style: TextStyle(
                  color: isPressed ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isPressed) ...[
                const SizedBox(width: 8),
                Image.asset(
                  'lib/images/check.png',
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
