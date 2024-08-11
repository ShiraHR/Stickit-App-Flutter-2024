import 'dart:io';

import 'package:final_project_3/models/random_options.dart';
import 'package:final_project_3/services/questions/questions_service.dart';
import 'package:json_annotation/json_annotation.dart';
import 'basic_question.dart';

part 'yes_no_question.g.dart';

@JsonSerializable()
class YesNoQuestion extends BasicQuestion {
  static final QuestionsService _questionsService = QuestionsService();
  final bool isCorrect;
  final StratEnd correctStep;
  final StratEnd wrongStep;

  YesNoQuestion({
    required super.numOfQuestion,
    required super.type,
    required super.imageURL,
    required super.question,
    required super.skill,
    required super.topic,
    required super.grades,
    required super.date,
    required this.isCorrect,
    required this.correctStep,
    required this.wrongStep,
  });

  static Future<YesNoQuestion> createInstance(
    File image,
    String question,
    String skill,
    String topic,
    List<String> grades,
    bool isCorrect,
    StratEnd correctStep,
    StratEnd wrongStep,
  ) async {
    BasicQuestion basicQuestion = await BasicQuestion.createInstace(
      "yes_no",
      image,
      question,
      skill,
      topic,
      grades,
    );

    YesNoQuestion newQuestion = YesNoQuestion(
      imageURL: basicQuestion.imageURL,
      question: basicQuestion.question,
      skill: basicQuestion.skill,
      topic: basicQuestion.topic,
      grades: basicQuestion.grades,
      isCorrect: isCorrect,
      numOfQuestion: basicQuestion.numOfQuestion,
      date: basicQuestion.date,
      type: basicQuestion.type,
      correctStep: correctStep,
      wrongStep: wrongStep,
    );

    await _questionsService.addQuestion(newQuestion);
    return newQuestion;
  }

  factory YesNoQuestion.fromJson(Map<String, dynamic> json) =>
      _$YesNoQuestionFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$YesNoQuestionToJson(this);
}