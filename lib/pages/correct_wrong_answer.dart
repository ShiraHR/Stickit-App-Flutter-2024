import 'package:final_project_3/pages/questions/generic_quesyion_page.dart';
import 'package:flutter/material.dart';
import 'package:final_project_3/components/earth_animation.dart';
import 'package:final_project_3/components/wide_button.dart';
import 'package:final_project_3/models/user.dart';
import 'package:final_project_3/pages/board_page.dart';
import 'package:flutter/material.dart';
import 'questions/generic_quesyion_page.dart';

class CorrectWrongAnswer extends StatelessWidget {
  final User user;
  final bool isCorrect;
  final int numOfQuestion;
  final int step;

  const CorrectWrongAnswer({
    Key? key,
    required this.user,
    required this.isCorrect,
    required this.numOfQuestion,
    required this.step,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isCorrect ? 'תשובה נכונה!' : 'אופס! זו טעות',
              style: TextStyle(
                color: isCorrect
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(Icons.keyboard_arrow_right, size: 24),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Center(
          child: Column(
            children: [
              Center(
                child: EarthAnimation(
                  number: numOfQuestion + step,
                  isCorrect: isCorrect,
                ),
              ),
              const Spacer(),
              WideButton(
                text: "לוח המשחק",
                color: "yellow",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BorderPage(
                        boardLength: user.gameBoard.questions.length,
                        borderNumber: user.boardNumber,
                        currentIndex: user.gameBoard.currentQuestion,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              WideButton(
                text: "לשאלה הבאה",
                onTap: () {
                  user.nextQuestion(numOfQuestion, isCorrect, step);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenericQuesyionPage(
                        question: user.gameBoard.getCurrentQuestion(),
                        user: user,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
