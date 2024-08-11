import 'package:final_project_3/components/questions/widgets.dart';
import 'package:final_project_3/components/questions_app_bar.dart';
import 'package:final_project_3/components/wide_button.dart';
import 'package:final_project_3/pages/correct_wrong_answer.dart';
import 'package:final_project_3/pages/end_game_page.dart';
import 'package:flutter/material.dart';
import '../../models/multipal_question.dart';
import '../../models/user.dart';

class MultipalQuestionPage extends StatefulWidget {
  final MultipalQuestion multipalQuestion;
  final User user;
  MultipalQuestionPage({required this.multipalQuestion, required this.user});
  _MultipalQuestionPageState createState() => _MultipalQuestionPageState();
}

class _MultipalQuestionPageState extends State<MultipalQuestionPage> {
  int _selectedAnswer = -1;
  bool _showIncorrectAnswers = false;

  @override
  void initState() {
    super.initState();
    // _initializeAnswers();
  }

  // void _initializeAnswers() {
  //   _selectedAnswer =
  //       List<bool>.filled(widget.multipalQuestion.answers.length, false);
  // }

  void _handleSubmit() {
    widget.user.updateAmswers();
    setState(() {
      _showIncorrectAnswers = true;
    });
    if (widget.user.gameBoard
        .isGameOver(widget.multipalQuestion.numOfQuestion)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EndGamePage(user: widget.user,),
        ),
      );
    } else {
      // widget.user.updateAmswers();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CorrectWrongAnswer(
            user: widget.user,
            isCorrect: widget.multipalQuestion.answers[_selectedAnswer].classification,
            numOfQuestion: widget.multipalQuestion.numOfQuestion,
            step: widget.multipalQuestion.answers[_selectedAnswer].step.step,
          ),
        ),
      );
    }
    // Future.delayed(Duration(milliseconds: 1000), () {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => NextPage(),
    //     ),
    //   );
    // });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 204, 232, 245),
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
                      ImageAndQuestion(widget.multipalQuestion.imageURL,
                          widget.multipalQuestion.question, 300),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
                    child: ListView.builder(
                        itemCount: widget.multipalQuestion.answers.length,
                        itemBuilder: (context, index) {
                          return RadioListTile<int>(
                              title: Text(
                                widget.multipalQuestion.answers[index].answer,
                                style: TextStyle(
                                  color: _showIncorrectAnswers &&
                                          _selectedAnswer == index &&
                                          !widget.multipalQuestion
                                              .answers[index].classification
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                              value: index,
                              groupValue: _selectedAnswer,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedAnswer = value!;
                                });
                              });
                        }),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.height * 0.06,
            right: MediaQuery.of(context).size.height * 0.06,
            bottom: MediaQuery.of(context).size.height * 0.4,
            child: questionInstructions(context, 'יש לסמן את התשובה הנכונה'),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.06,
            right: MediaQuery.of(context).size.width * 0.06,
            bottom: MediaQuery.of(context).size.height * 0.01,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: WideButton(
                text: 'שלח',
                onTap: _handleSubmit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


