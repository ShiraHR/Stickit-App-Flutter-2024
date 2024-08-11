import 'package:final_project_3/models/answer.dart';
import 'package:final_project_3/models/basic_question.dart';
import 'package:final_project_3/models/multipal_question.dart';
import 'package:final_project_3/models/user.dart';
import 'package:final_project_3/models/words_in_order_question.dart';
import 'package:final_project_3/models/yes_no_question.dart';
import 'package:final_project_3/pages/questions/full_multiple_question_page.dart';
import 'package:final_project_3/pages/questions/yes_no_question_page.dart';
import 'package:flutter/material.dart';
import '../../components/questions_app_bar.dart';
import 'multipal_question_page.dart';
import 'words_in_order_question_page.dart';

class GenericQuesyionPage extends StatelessWidget {
  final BasicQuestion question;
  final User user;
  GenericQuesyionPage({required this.question, required this.user});

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;

    if (question is MultipalQuestion) {
      int counter = 0;

      for (Answer a in (question as MultipalQuestion).answers) {
        if (a.classification) {
          counter++;
        }
      }
      if (counter > 1) {
        bodyContent = FullMultipleQuestion(
          question: question as MultipalQuestion,
          user: user,
        );
      } else {
        bodyContent = MultipalQuestionPage(
          multipalQuestion: question as MultipalQuestion,
          user: user,
        );
      }
    } else if (question is YesNoQuestion) {
      bodyContent = YesNoQuestionPage(
        question: question as YesNoQuestion,
        user: user,
      );
    } else if (question is WordsInOrderQuestion) {
      bodyContent = WordsInOrderQuestionPage(
          question: question as WordsInOrderQuestion, user: user);
    } else {
      bodyContent = Center(child: Text('Unknown question type'));
    }
    return Scaffold(
      appBar: QuestionsAppBar(
        numOfBoard: user.boardNumber,
        questionsAnswered: user.gameBoard.currentQuestion,
        totalQuestions: user.gameBoard.numOfQuestions,
      ),
      backgroundColor: Color.fromARGB(255, 204, 232, 245),
      body: bodyContent,
    );
  }
}
