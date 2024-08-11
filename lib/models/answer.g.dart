// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
      answer: json['answer'] as String,
      classification: json['classification'] as bool,
      qeyWord: json['qeyWord'] as String,
      step: StratEnd.fromJson(json['step'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'answer': instance.answer,
      'classification': instance.classification,
      'qeyWord': instance.qeyWord,
      'step': instance.step.toJson(),  // Assuming StratEnd has a toJson method
    };