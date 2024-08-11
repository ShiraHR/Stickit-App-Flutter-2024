import 'package:final_project_3/pages/correct_wrong_answer.dart';
import 'package:flutter/material.dart';
import 'package:final_project_3/models/words_in_order_question.dart';
import '../../components/questions/widgets.dart';
import '../../models/user.dart';
import '../end_game_page.dart';

class WordsInOrderQuestionPage extends StatefulWidget {
  final WordsInOrderQuestion question;
  final User user;

  WordsInOrderQuestionPage({
    required this.question,
    required this.user,
  }){
print(question);
  }

  @override
  _WordsInOrderQuestionPageState createState() =>
      _WordsInOrderQuestionPageState();
}

class _WordsInOrderQuestionPageState extends State<WordsInOrderQuestionPage> {
  int wrongAnswers = 0;
  int index = 0;
  // List<String> shuffledWords = [];
  List<String> selectedWords = [];
  List<bool> correctStatus = [];
  Map<int, bool> buttonErrorStatus = {};
  Map<int, bool> buttonCorrectStatus = {}; // Track correct buttons

  // @override
  // void initState() {
  //   super.initState();
  //   shuffledWords = List.from(widget.question.words)..shuffle();
  //   correctStatus = List.filled(widget.question.words.length, false);
  // }

  void _handleButtonTap(String word, int buttonIndex) {
    setState(() {
      if (index < widget.question.words.length &&
          widget.question.words[index] == word) {
        correctStatus[index] = true;
        selectedWords.add(word);
        index++;
        buttonErrorStatus[buttonIndex] = false; // Remove error status if correct
        buttonCorrectStatus[buttonIndex] = true; // Mark button as correct

        if (index == widget.question.words.length) {
          widget.user.updateAmswers();
          _navigateToNextQuestion();
        }
      } else {
        wrongAnswers++;
        correctStatus[index] = false;
        buttonErrorStatus[buttonIndex] = true;

        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            buttonErrorStatus.remove(buttonIndex);
          });
        });
      }
    });
  }

  void _navigateToNextQuestion() {
    if (widget.user.gameBoard
        .isGameOver(widget.user.gameBoard.currentQuestion)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EndGamePage(user: widget.user,),
        ),
      );
    } else {
      widget.user.updateAmswers();

      if (wrongAnswers >= 3) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CorrectWrongAnswer(
              user: widget.user,
              isCorrect: false,
              numOfQuestion: widget.question.numOfQuestion,
              step: widget.question.randomoptions.threePlusTwoWrongAns.step,
            ),
          ),
        );
      } else if (wrongAnswers > 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CorrectWrongAnswer(
              user: widget.user,
              isCorrect: true,
              numOfQuestion: widget.question.numOfQuestion,
              step: widget.question.randomoptions.oneTwoWrongAns.step,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CorrectWrongAnswer(
              user: widget.user,
              isCorrect: true,
              numOfQuestion: widget.question.numOfQuestion,
              step: widget.question.randomoptions.noWrongAns.step,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 227, 253, 224),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageAndQuestion(widget.question.imageURL,
                        widget.question.question, 300),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      alignment: WrapAlignment.end,
                      children: List.generate(
                          widget.question.words.length, (index) {
                        String word = index < selectedWords.length
                            ? selectedWords[index]
                            : '?';
                        Color backgroundColor = index < selectedWords.length
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white;
                        Color textColor = index < selectedWords.length
                            ? Colors.white
                            : Theme.of(context).colorScheme.primary;
                        return _container(
                          textColor,
                          backgroundColor,
                          word,
                        );
                      }).reversed.toList(), // reverse the order
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Center(
                    child: Wrap(
                      spacing: MediaQuery.of(context).size.height * 0.03,
                      runSpacing: MediaQuery.of(context).size.height * 0.015,
                      children:
                          List.generate(widget.question.sortedWords.length, (buttonIndex) {
                        bool isSelected =
                            selectedWords.contains(widget.question.sortedWords[buttonIndex]);
                        bool isError = buttonErrorStatus[buttonIndex] ?? false;
                        bool isCorrect =
                            buttonCorrectStatus[buttonIndex] ?? false;
                        return GestureDetector(
                          onTap: isSelected
                              ? null
                              : () => _handleButtonTap(
                                  widget.question.sortedWords[buttonIndex], buttonIndex),
                          child: Container(
                            width: 143,
                            height: 45,
                            decoration: BoxDecoration(
                              color: isCorrect
                                  ? Theme.of(context).colorScheme.primary
                                  : (isError
                                      ? Theme.of(context).colorScheme.error
                                      : Colors.white),
                              border: Border.all(
                                color: isCorrect
                                    ? Colors.transparent
                                    : (isError
                                        ? Colors.transparent
                                        : Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.question.sortedWords[buttonIndex],
                                    style: TextStyle(
                                      color: isCorrect || isError
                                          ? Colors.white
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (isCorrect)
                                    const Icon(Icons.check,
                                        color: Colors.white),
                                  if (isError)
                                    const Icon(Icons.close,
                                        color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.height * 0.06,
            right: MediaQuery.of(context).size.height * 0.06,
            bottom: MediaQuery.of(context).size.height * 0.2,
            child: questionInstructions(context, "סדרו את המילים בסדר הנכון"),
          ),
        ],
      ),
    );
  }

  Widget _container(Color textColor, Color backgroundColor, String value) {
    return Container(
      width: 70,
      height: 35,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: Center(
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18.0, color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
