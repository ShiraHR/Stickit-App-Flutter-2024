// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicQuestion _$BasicQuestionFromJson(Map<String, dynamic> json) =>
    BasicQuestion(
      numOfQuestion: (json['numOfQuestion'] as num).toInt(),
      type: json['type'] as String,
      imageURL: json['imageURL'] as String,
      question: json['question'] as String,
      skill: json['skill'] as String,
      topic: json['topic'] as String,
      grades:
          (json['grades'] as List<dynamic>).map((e) => e as String).toList(),
      date: json['date'] as String,
      status: json['status'] as bool? ?? false,
    );

Map<String, dynamic> _$BasicQuestionToJson(BasicQuestion instance) =>
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
    };
