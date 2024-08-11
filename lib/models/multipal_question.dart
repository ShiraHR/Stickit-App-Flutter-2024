import 'dart:io';

import 'package:final_project_3/services/questions/questions_service.dart';
import 'package:json_annotation/json_annotation.dart';

import 'basic_question.dart';
import 'answer.dart';

part 'multipal_question.g.dart';

@JsonSerializable()
class MultipalQuestion extends BasicQuestion {
  static final QuestionsService _questionsService = QuestionsService();
  final List<Answer> answers;

  MultipalQuestion({
    required super.numOfQuestion,
    required super.type,
    required super.imageURL,
    required super.question,
    required super.skill,
    required super.topic,
    required super.grades,
    required this.answers,
    required super.date,
  });

  static Future<MultipalQuestion> createInstance(
    File image,
    String question,
    String skill,
    String topic,
    List<String> grades,
    List<Answer> answers,
  ) async {
    BasicQuestion basicQuestion = await BasicQuestion.createInstace(
      "multipal",
      image,
      question,
      skill,
      topic,
      grades,
    );

    MultipalQuestion newQuestion = MultipalQuestion(
      numOfQuestion: basicQuestion.numOfQuestion,
      type: basicQuestion.type,
      imageURL: basicQuestion.imageURL,
      question: basicQuestion.question,
      skill: basicQuestion.skill,
      topic: basicQuestion.topic,
      grades: basicQuestion.grades,
      answers: answers,
      date: basicQuestion.date,
    );

    await _questionsService.addQuestion(newQuestion);
    return newQuestion;
  }

  factory MultipalQuestion.fromJson(Map<String, dynamic> json) =>
      _$MultipalQuestionFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MultipalQuestionToJson(this);
}
