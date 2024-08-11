import 'package:final_project_3/models/user.dart';
import 'package:final_project_3/models/yes_no_question.dart';
import 'package:final_project_3/pages/correct_wrong_answer.dart';
import 'package:flutter/material.dart';
import '../../components/questions/widgets.dart';
import '../../components/questions/yes_no_button.dart';
import '../end_game_page.dart';

class YesNoQuestionPage extends StatefulWidget {
  final YesNoQuestion question;
  final User user;

  YesNoQuestionPage({
    required this.question,
    required this.user,
  });

  @override
  _YesNoQuestionPageState createState() => _YesNoQuestionPageState();
}

class _YesNoQuestionPageState extends State<YesNoQuestionPage> {
  @override
  void initState() {
    super.initState();
  }

  bool _isYesTapped = false;
  bool _isNoTapped = false;
  bool _yesButtonCorrect = false;
  bool _noButtonCorrect = false;

  void _handleButtonTap(bool isYesButton) {
    widget.user.updateAmswers();
    setState(() {
      if (isYesButton) {
        _isYesTapped = true;
        _yesButtonCorrect = widget.question.isCorrect;
        _noButtonCorrect = !widget.question.isCorrect;
      } else {
        _isNoTapped = true;
        _noButtonCorrect = !widget.question.isCorrect;
        _yesButtonCorrect = widget.question.isCorrect;
      }

      bool isGameFinished = widget.user.gameBoard.isGameOver(widget.user.gameBoard.currentQuestion);
      bool isAnswerCorrect = isYesButton == widget.question.isCorrect;

      if (isGameFinished) {
        widget.user.finishBoard();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EndGamePage(user: widget.user),),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CorrectWrongAnswer(
              user: widget.user,
              isCorrect: isAnswerCorrect,
              numOfQuestion: widget.user.gameBoard.currentQuestion,
              step: isAnswerCorrect ? widget.question.correctStep.step : widget.question.wrongStep.step,
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
                      ImageAndQuestion(
                        widget.question.imageURL,
                        widget.question.question,
                        500,
                      ),
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
                  padding: const EdgeInsets.only(
                    top: 50.0,
                    bottom: 50,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          YesNoButton(
                            text: 'נכון',
                            isTapped: _isYesTapped,
                            isCorrect: _yesButtonCorrect,
                            onTap: () => _handleButtonTap(true),
                          ),
                          YesNoButton(
                            text: 'לא נכון',
                            isTapped: _isNoTapped,
                            isCorrect: _noButtonCorrect,
                            onTap: () => _handleButtonTap(false),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.height * 0.06,
            right: MediaQuery.of(context).size.height * 0.06,
            bottom: MediaQuery.of(context).size.height * 0.15,
            child: questionInstructions(context, '"יש לענות "נכון" או "לא נכון'),
          ),
        ],
      ),
    );
  }
}