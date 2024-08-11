import 'package:json_annotation/json_annotation.dart';

import 'random_options.dart';

part 'answer.g.dart';

@JsonSerializable()
class Answer {
  late final String answer;
  late final bool classification;
  String qeyWord;
  final StratEnd step;
  
  Answer({
    required this.answer,
    required this.classification,
    required this.qeyWord,
    required this.step,
  });

  factory Answer.fromJson(Map<String, dynamic> json) =>
      _$AnswerFromJson(json);
  
  Map<String, dynamic> toJson() => _$AnswerToJson(this);

  // Convert Answer object to a Map
  Map<String, dynamic> toMap() {
    return {
      'answer': answer,
      'classification': classification,
      'qeyWord': qeyWord,
      'step': step.toJson(),  // Assuming StratEnd has a toJson method
    };
  }

  // Create Answer object from a Map
  static Answer fromMap(Map<String, dynamic> map) {
    return Answer(
      answer: map['answer'],
      classification: map['classification'],
      qeyWord: map['qeyWord'],
      step: StratEnd.fromJson(map['step']),  // Assuming StratEnd has a fromJson method
    );
  }
}