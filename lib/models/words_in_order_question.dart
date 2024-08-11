import 'dart:io';

import 'package:final_project_3/services/questions/questions_service.dart';
import 'package:json_annotation/json_annotation.dart';

import 'basic_question.dart';

import 'random_options.dart';

part 'words_in_order_question.g.dart';

@JsonSerializable()
class WordsInOrderQuestion extends BasicQuestion {
  static final QuestionsService _questionsService = QuestionsService();
  final List<String> words;
  final List<String> sortedWords;
  final Randomoptions randomoptions;
  int wrongAnswers;
  WordsInOrderQuestion({
    required super.numOfQuestion,
    required super.type,
    required super.imageURL,
    required super.question,
    required super.skill,
    required super.topic,
    required super.grades,
    required super.date,
    required this.sortedWords,
    this.wrongAnswers = 0,
    required this.randomoptions,
    required this.words,
  });

  static Future<WordsInOrderQuestion> createInstance(
      File image,
      String question,
      String skill,
      String topic,
      List<String> grades,
      List<String> sortedWords,
      Randomoptions randomoptions,
      {int wrongAnswers = 0}) async {
    BasicQuestion basicQuestion = await BasicQuestion.createInstace(
      "words_in_order",
      image,
      question,
      skill,
      topic,
      grades,
    );

    WordsInOrderQuestion newQuestion = WordsInOrderQuestion(
      imageURL: basicQuestion.imageURL,
      question: basicQuestion.question,
      skill: basicQuestion.skill,
      topic: basicQuestion.topic,
      grades: basicQuestion.grades,
      sortedWords: sortedWords,
      wrongAnswers: wrongAnswers,
      randomoptions: randomoptions,
      numOfQuestion: basicQuestion.numOfQuestion,
      type: basicQuestion.type,
      words: question.split(' '),
      date: basicQuestion.date,
    );
    await _questionsService.addQuestion(newQuestion);
    return newQuestion;
  }

  factory WordsInOrderQuestion.fromJson(Map<String, dynamic> json) =>
      _$WordsInOrderQuestionFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$WordsInOrderQuestionToJson(this);

  bool checkAnswer(String ans, int index) {
    if (ans != words[index]) {
      wrongAnswers++;
      return true;
    } else {
      return false;
    }
  }
}
