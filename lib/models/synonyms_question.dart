import 'dart:io';

import 'package:final_project_3/services/questions/questions_service.dart';
import 'package:json_annotation/json_annotation.dart';

import 'basic_question.dart';

import 'random_options.dart';

part 'synonyms_question.g.dart';

@JsonSerializable()
class SynonymsQuestion extends BasicQuestion {
  static final QuestionsService _questionsService = QuestionsService();
  final Map<String, String> allWords;
  final Randomoptions randomoptions;
  int wrongAnswers;
  SynonymsQuestion({
    required super.numOfQuestion,
    required super.type,
    required super.imageURL,
    required super.question,
    required super.skill,
    required super.topic,
    required super.grades,
    required super.date,
    required this.allWords,
    required this.randomoptions,
    this.wrongAnswers = 0,
  });

  static Future<SynonymsQuestion> createInstance(
      File image,
      String question,
      String skill,
      String topic,
      List<String> grades,
      final Map<String, String> allWords,
      Randomoptions randomoptions,
      {int wrongAnswers = 0}) async {
    BasicQuestion basicQuestion = await BasicQuestion.createInstace(
      "synonyms",
      image,
      question,
      skill,
      topic,
      grades,
    );

    SynonymsQuestion newQuestion = SynonymsQuestion(
      imageURL: basicQuestion.imageURL,
      question: basicQuestion.question,
      skill: basicQuestion.skill,
      topic: basicQuestion.topic,
      grades: basicQuestion.grades,
      allWords: allWords,
      randomoptions: randomoptions,
      wrongAnswers: wrongAnswers,
      numOfQuestion: basicQuestion.numOfQuestion,
      type: basicQuestion.type,
      date: basicQuestion.date,
    );

    await _questionsService.addQuestion(newQuestion);
    return newQuestion;
  }

  factory SynonymsQuestion.fromJson(Map<String, dynamic> json) =>
      _$SynonymsQuestionFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SynonymsQuestionToJson(this);

  bool isWrongAnswers(String word, String synonymWord) {
    String value =
        allWords.entries.firstWhere((entry) => entry.key == word).value;
    if (value != synonymWord) {
      wrongAnswers++;
      return true;
    } else {
      return false;
    }
  }
}
