// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'dart:math';

// class EarthAnimation extends StatefulWidget {
//   final int number;
//   final String imageUrl;

//   EarthAnimation({Key? key, required this.number, required this.imageUrl}) : super(key: key);

//   @override
//   _EarthAnimationState createState() => _EarthAnimationState();
// }

// class _EarthAnimationState extends State<EarthAnimation> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 5),
//       vsync: this,
//     )..repeat();

//     _animation = Tween<double>(begin: 0, end: -pi).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Directionality(
//         textDirection: TextDirection.rtl,
//         child: SafeArea(
//           child: Center(
//             child: SizedBox(
//               width: 400,
//               height: 400,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   AnimatedBuilder(
//                     animation: _controller,
//                     builder: (context, child) {
//                       double progress = _controller.value;
//                       double startX = 400; // Start position (off-screen)
//                       double startY = 0; // Start position (off-screen)
//                       double endX = 200; // End position (center of Earth)
//                       double endY = 200; // End position (center of Earth)
//                       double x = startX + (endX - startX) * progress;
//                       double y = startY + (endY - startY) * progress;
//                       double opacity = progress < 0.5 ? 1.0 : 0.0; // Disappear halfway through

//                       return Positioned(
//                         left: x,
//                         top: y,
//                         child: Opacity(
//                           opacity: opacity,
//                           child: SvgPicture.asset('lib/images/comet.svg', width: 40, height: 40),
//                         ),
//                       );
//                     },
//                   ),
//                   AnimatedBuilder(
//                     animation: _animation,
//                     builder: (context, child) {
//                       return Transform.rotate(
//                         angle: _animation.value,
//                         child: SvgPicture.asset(widget.imageUrl, width: 300, height: 300),
//                       );
//                     },
//                   ),
//                   AnimatedBuilder(
//                     animation: _animation,
//                     builder: (context, child) {
//                       double angle = _animation.value;
//                       double radius = 100; // radius of the circular path
//                       double x = radius * cos(angle);
//                       double y = radius * sin(angle);
//                       return Positioned(
//                         left: x + 150, // offset to center the animation
//                         top: y + 150, // offset to center the animation
//                         child: SvgPicture.asset('lib/images/astronaut.svg', width: 80, height: 80),
//                       );
//                     },
//                   ),
//                   AnimatedBuilder(
//                     animation: _controller,
//                     builder: (context, child) {
//                       double progress = _controller.value;
//                       // Show the number only after the comet disappears (progress >= 0.5)
//                       return Visibility(
//                         visible: progress >= 0.5,
//                         child: Center(
//                           child: Text(
//                             '${widget.number}', // Replace with any number or dynamic value
//                             style: const TextStyle(
//                               fontSize: 100,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_svg/flutter_svg.dart';

class EarthAnimation extends StatefulWidget {
  final int number;
  final bool isCorrect;

  const EarthAnimation({
    Key? key,
    required this.number,
    required this.isCorrect,
  }) : super(key: key);

  @override
  _EarthAnimationState createState() => _EarthAnimationState();
}

class _EarthAnimationState extends State<EarthAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: -pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildCometAnimation(),
              _buildEarthRotation(),
              _buildAstronautOrbit(),
              _buildNumberDisplay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCometAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double progress = _controller.value;
        double startX = 400;
        double startY = 0;
        double endX = 200;
        double endY = 200;
        double x = startX + (endX - startX) * progress;
        double y = startY + (endY - startY) * progress;
        double opacity = progress < 0.5 ? 1.0 : 0.0;

        return Positioned(
          left: x,
          top: y,
          child: Opacity(
            opacity: opacity,
            child: SvgPicture.asset('lib/images/comet.svg', width: 40, height: 40),
          ),
        );
      },
    );
  }

  Widget _buildEarthRotation() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value,
          child: SvgPicture.asset(widget.isCorrect? 'lib/images/earth.svg' : 'lib/images/wrong.svg', width: 300, height: 300),
        );
      },
    );
  }

  Widget _buildAstronautOrbit() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        double angle = _animation.value;
        double radius = 100;
        double x = radius * cos(angle);
        double y = radius * sin(angle);
        return Positioned(
          left: x + 150,
          top: y + 150,
          child: SvgPicture.asset('lib/images/astronaut.svg', width: 80, height: 80),
        );
      },
    );
  }

  Widget _buildNumberDisplay() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double progress = _controller.value;
        return Visibility(
          visible: progress >= 0.5,
          child: Center(
            child: Text(
              '${widget.number}',
              style: const TextStyle(
                fontSize: 100,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
