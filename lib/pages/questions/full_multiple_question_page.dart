import 'package:final_project_3/models/multipal_question.dart';
import 'package:final_project_3/models/user.dart';
import 'package:final_project_3/pages/correct_wrong_answer.dart';
import 'package:final_project_3/pages/end_game_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../components/questions/widgets.dart';
import '../../components/wide_button.dart';

class FullMultipleQuestion extends StatefulWidget {
  final MultipalQuestion question;
  final User user;

  FullMultipleQuestion({
    required this.question,
    required this.user,
  });

  @override
  _FullMultipleQuestionState createState() => _FullMultipleQuestionState();
}

class _FullMultipleQuestionState extends State<FullMultipleQuestion> {
  static int answers = 0;
  List<bool> _selectedAnswers = [];
  bool _showIncorrectAnswers = false;
  int selectedAnswersCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeAnswers();
  }

  void _initializeAnswers() {
    answers = widget.question.answers.where((a) => a.classification).length;
    _selectedAnswers = List<bool>.filled(widget.question.answers.length, false);
  }

  bool get _isNumberOfSelectionsCorrect {
    selectedAnswersCount =
        _selectedAnswers.where((isSelected) => isSelected).length;
    return selectedAnswersCount == answers;
  }

  int stepSize() {
    int sum = 0;
    for (int i = 0; i < _selectedAnswers.length;) {
      if (_selectedAnswers[i]) {
        if (widget.question.answers[i].classification) {
          sum += widget.question.answers[i].step.step;
        } else {
          sum -= widget.question.answers[i].step.step;
        }
      }
    }
    return sum;
  }

  bool nextOrPrevQuestion(int step){
    if (step > 0) {
     return true;
    } else {
      return false;
    }
  }

  void _handleSubmit() {
    setState(() {
      _showIncorrectAnswers = true;
    });
    int step = stepSize();
    bool nextOrPrev = nextOrPrevQuestion(step);
    if (!nextOrPrev) {
      step = step * -1;
    } 
    Future.delayed(Duration(milliseconds: 1000), () {
      if (!widget.user.gameBoard
          .isGameOver(widget.user.gameBoard.currentQuestion)) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EndGamePage(user: widget.user,),
          ),
        );
      } else {
        widget.user.updateAmswers();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CorrectWrongAnswer(
              isCorrect: nextOrPrev, numOfQuestion: widget.question.numOfQuestion, step: step, user: widget.user,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageAndQuestion(widget.question.imageURL,
                          widget.question.question, 250),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: widget.question.answers.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(
                            widget.question.answers[index].answer,
                            style: TextStyle(
                              color: _showIncorrectAnswers &&
                                      _selectedAnswers[index] &&
                                      !widget.question.answers[index]
                                          .classification
                                  ? Colors.red
                                  : Colors.black,
                            ),
                          ),
                          value: _selectedAnswers[index],
                          onChanged: (bool? value) {
                            setState(() {
                              _selectedAnswers[index] = value ?? false;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.height * 0.06,
            right: MediaQuery.of(context).size.height * 0.06,
            bottom: MediaQuery.of(context).size.height * 0.4,
            child: questionInstructions(
                context, 'יש לסמן את ${answers} התשובות הנכונות'),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.06,
            right: MediaQuery.of(context).size.width * 0.06,
            bottom: MediaQuery.of(context).size.height * 0.01,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: WideButton(
                text: 'שלח',
                onTap: _isNumberOfSelectionsCorrect ? _handleSubmit : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

