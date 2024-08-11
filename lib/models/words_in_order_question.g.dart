// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'words_in_order_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordsInOrderQuestion _$WordsInOrderQuestionFromJson(
        Map<String, dynamic> json) =>
    WordsInOrderQuestion(
      numOfQuestion: (json['numOfQuestion'] as num).toInt(),
      type: json['type'] as String,
      imageURL: json['imageURL'] as String,
      question: json['question'] as String,
      skill: json['skill'] as String,
      topic: json['topic'] as String,
      grades:
          (json['grades'] as List<dynamic>).map((e) => e as String).toList(),
      date: json['date'] as String,
      sortedWords: (json['sortedWords'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      wrongAnswers: (json['wrongAnswers'] as num?)?.toInt() ?? 0,
      randomoptions:
          Randomoptions.fromJson(json['randomoptions'] as Map<String, dynamic>),
      words: (json['words'] as List<dynamic>).map((e) => e as String).toList(),
    )..status = json['status'] as bool;

Map<String, dynamic> _$WordsInOrderQuestionToJson(
        WordsInOrderQuestion instance) =>
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
      'words': instance.words,
      'sortedWords': instance.sortedWords,
      'randomoptions': instance.randomoptions.toJson(),
      'wrongAnswers': instance.wrongAnswers,
    };
