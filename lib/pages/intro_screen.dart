import 'package:final_project_3/pages/login_page_one.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentScreen = 0;

  @override
  void initState() {
    super.initState();
  }

  void nextScreen() {
    setState(() {
      currentScreen = (currentScreen + 1) % 3;
    });
  }

  void prevScreen() {
    setState(() {
      currentScreen = (currentScreen - 1 + 3) % 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: IndexedStack(
        index: currentScreen,
        children: [
          _buildIntro1(),
          _buildIntro2(context),
          _buildIntro3(),
        ],
      ),
    );
  }

  Widget _buildIntro1() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
            child: Image.asset(
              './lib/images/game_name.png',
              width: 200,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            './lib/images/child.png',
            height: 300,
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: () {
                nextScreen();
              },
              child: Image.asset(
                './lib/images/back.png',
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntro2(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  './lib/images/board.png',
                  width: 300,
                  height: 300,
                ),
                Positioned(
                  bottom: -200,
                  child: Image.asset(
                    './lib/images/ABC.png',
                    width: 250,
                    height: 500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
              child: InkWell(
            onTap: () {
              prevScreen();
            },
            child: Image.asset(
              './lib/images/navigator.png',
              height: 60,
            ),
          )),
          const Text(
            'משחק מאתגר, מהנה וחווייתי לפיתוח מיומנויות למידה',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Center(
              child: InkWell(
            onTap: () {
              nextScreen();
            },
            child: Image.asset(
              './lib/images/next.png',
              height: 100,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildIntro3() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  './lib/images/board.png',
                  width: 300,
                  height: 300,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
              child: InkWell(
            onTap: () {
              prevScreen();
            },
            child: Image.asset(
              './lib/images/navigator.png',
              height: 60,
            ),
          )),
          const Text(
            'ענו על שאלות בלוח המשחק ממשבצת 1, התקדמו במשבצות עד למשבצת 100. מילאתם את כל אלבום המדבקות? מעולה. תוכלו להתחיל למלא אלבום מדבקות נוסף. סקרנים? מתחילים',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Center(
              child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Image.asset(
              './lib/images/next.png',
              height: 100,
            ),
          )),
        ],
      ),
    );
  }
}
