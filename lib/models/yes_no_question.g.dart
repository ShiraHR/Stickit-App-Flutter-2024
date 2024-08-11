// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yes_no_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YesNoQuestion _$YesNoQuestionFromJson(Map<String, dynamic> json) =>
    YesNoQuestion(
      numOfQuestion: (json['numOfQuestion'] as num).toInt(),
      type: json['type'] as String,
      imageURL: json['imageURL'] as String,
      question: json['question'] as String,
      skill: json['skill'] as String,
      topic: json['topic'] as String,
      grades:
          (json['grades'] as List<dynamic>).map((e) => e as String).toList(),
      date: json['date'] as String,
      isCorrect: json['isCorrect'] as bool,
      correctStep:
          StratEnd.fromJson(json['correctStep'] as Map<String, dynamic>),
      wrongStep: StratEnd.fromJson(json['wrongStep'] as Map<String, dynamic>),
    )..status = json['status'] as bool;

Map<String, dynamic> _$YesNoQuestionToJson(YesNoQuestion instance) =>
    <String, dynamic>{
      'numOfQuestion': instance.numOfQuestion,
      'type': instance.type,
      'imageURL': instance.imageURL,
      'question': instance.question,
      'skill': instance.skill,
      'topic': instance.topic,
      'grades': instance.grades,
      'status': instance.status,
      'date': instance.date,
      'isCorrect': instance.isCorrect,
      'correctStep': instance.correctStep.toJson(),
      'wrongStep': instance.wrongStep.toJson(),
    };
