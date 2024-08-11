import 'dart:io';

import 'package:final_project_3/services/questions/questions_service.dart';
import 'package:json_annotation/json_annotation.dart';

import 'basic_question.dart';
import 'random_options.dart';

part 'complete_words_question.g.dart';

@JsonSerializable()
class CompleteWordsQuestion extends BasicQuestion {
  static final QuestionsService _questionsService = QuestionsService();
  final List<String> sentenceToWords;
  final List<String> missingWords;
  final List<String>? distractingWords;
  final Randomoptions randomoptions;
  int wrongAnswers;

  CompleteWordsQuestion({
    required super.numOfQuestion,
    required super.type,
    required super.imageURL,
    required super.question,
    required super.skill,
    required super.topic,
    required super.grades,
    required this.sentenceToWords,
    required this.missingWords,
    this.distractingWords,
    required this.randomoptions,
    this.wrongAnswers = 0,
    required super.date,
  });

  static Future<CompleteWordsQuestion> createInstance(
    File image,
    String question,
    String skill,
    String topic,
    List<String> grades,
    List<String> missingWords,
    Randomoptions randomoptions, {
    List<String>? distractingWords,
  }) async {
    BasicQuestion basicQuestion = await BasicQuestion.createInstace(
      "complete_words",
      image,
      question,
      skill,
      topic,
      grades,
    );

    CompleteWordsQuestion newQuestion = CompleteWordsQuestion(
      numOfQuestion: basicQuestion.numOfQuestion,
      type: basicQuestion.type,
      imageURL: basicQuestion.imageURL,
      question: basicQuestion.question,
      skill: basicQuestion.skill,
      topic: basicQuestion.topic,
      grades: basicQuestion.grades,
      missingWords: missingWords,
      distractingWords: distractingWords,
      randomoptions: randomoptions,
      sentenceToWords: question.split(' '),
      date: basicQuestion.date,
    );

    await _questionsService.addQuestion(newQuestion);
    return newQuestion;
  }

  factory CompleteWordsQuestion.fromJson(Map<String, dynamic> json) =>
      _$CompleteWordsQuestionFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CompleteWordsQuestionToJson(this);

  bool checkAnswer(String ans, int index) {
    if (ans != sentenceToWords[index]) {
      wrongAnswers++;
      return true;
    } else {
      return false;
    }
  }
}
