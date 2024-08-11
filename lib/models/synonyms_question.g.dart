// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synonyms_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SynonymsQuestion _$SynonymsQuestionFromJson(Map<String, dynamic> json) =>
    SynonymsQuestion(
      numOfQuestion: (json['numOfQuestion'] as num).toInt(),
      type: json['type'] as String,
      imageURL: json['imageURL'] as String,
      question: json['question'] as String,
      skill: json['skill'] as String,
      topic: json['topic'] as String,
      grades:
          (json['grades'] as List<dynamic>).map((e) => e as String).toList(),
      date: json['date'] as String,
      allWords: Map<String, String>.from(json['allWords'] as Map),
      randomoptions:
          Randomoptions.fromJson(json['randomoptions'] as Map<String, dynamic>),
      wrongAnswers: (json['wrongAnswers'] as num?)?.toInt() ?? 0,
    )..status = json['status'] as bool;

Map<String, dynamic> _$SynonymsQuestionToJson(SynonymsQuestion instance) =>
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
      'allWords': instance.allWords,
      'randomoptions': instance.randomoptions.toJson(),
      'wrongAnswers': instance.wrongAnswers,
    };
