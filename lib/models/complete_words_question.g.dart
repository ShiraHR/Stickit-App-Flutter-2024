// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_words_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteWordsQuestion _$CompleteWordsQuestionFromJson(
        Map<String, dynamic> json) =>
    CompleteWordsQuestion(
      numOfQuestion: (json['numOfQuestion'] as num).toInt(),
      type: json['type'] as String,
      imageURL: json['imageURL'] as String,
      question: json['question'] as String,
      skill: json['skill'] as String,
      topic: json['topic'] as String,
      grades:
          (json['grades'] as List<dynamic>).map((e) => e as String).toList(),
      sentenceToWords: (json['sentenceToWords'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      missingWords: (json['missingWords'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      distractingWords: (json['distractingWords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      randomoptions:
          Randomoptions.fromJson(json['randomoptions'] as Map<String, dynamic>),
      wrongAnswers: (json['wrongAnswers'] as num?)?.toInt() ?? 0,
      date: json['date'] as String,
    )..status = json['status'] as bool;

Map<String, dynamic> _$CompleteWordsQuestionToJson(
        CompleteWordsQuestion instance) =>
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
      'sentenceToWords': instance.sentenceToWords,
      'missingWords': instance.missingWords,
      'distractingWords': instance.distractingWords,
      'randomoptions': instance.randomoptions.toJson(),
      'wrongAnswers': instance.wrongAnswers,
    };
