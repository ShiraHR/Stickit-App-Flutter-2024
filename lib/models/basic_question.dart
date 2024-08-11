import 'dart:io';

import 'package:final_project_3/services/questions/questions_service.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../services/image_service.dart';

part 'basic_question.g.dart';

@JsonSerializable()
class BasicQuestion {
  static final QuestionsService _questionsService = QuestionsService();
  static final ImageService _imageService = ImageService();
  final int numOfQuestion;
  final String type;
  final String imageURL;
  final String question;
  final String skill;
  final String topic;
  final List<String> grades;
  bool status;
  final String date;

  BasicQuestion({
    required this.numOfQuestion,
    required this.type,
    required this.imageURL,
    required this.question,
    required this.skill,
    required this.topic,
    required this.grades,
    required this.date,
    this.status = false,
  });

  static Future<BasicQuestion> createInstace(
    String type,
    File image,
    String question,
    String skill,
    String topic,
    List<String> grades,
  ) async {
    print(question);
    String imageURL = await _imageService.uploadImage(image);
    int numOfQuestions = await _initializeQuestionNum();
    return BasicQuestion(
      numOfQuestion: numOfQuestions,
      type: type,
      imageURL: imageURL,
      question: question,
      skill: skill,
      topic: topic,
      grades: grades,
      date: DateFormat('yyyy-MM-dd').format(DateTime.now())
    );
  }

  void updateStatus(bool newStatus) {
    status = !status;
  }

  factory BasicQuestion.fromJson(Map<String, dynamic> json) =>
      _$BasicQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$BasicQuestionToJson(this);

  static Future<int> _initializeQuestionNum() async {
    int highestId = await _questionsService.getHighestId();
    return highestId + 1;
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'numOfQuestion': numOfQuestion,
  //     'imageURL': imageURL,
  //     'question': question,
  //     'skill': skill,
  //     'topic': topic,
  //     'grades': grades,
  //     'status': status,
  //     'date': date,
  //   };
  // }

  // // Create BasicQuestion object from a Map
  // static BasicQuestion fromMap(Map<String, dynamic> map) {
  //   return BasicQuestion(
  //     type: map['type'],
  //     imageURL: map['imageURL'],
  //     question: map['question'],
  //     skill: map['skill'],
  //     topic: map['topic'],
  //     grades: List<String>.from(map['grades']),
  //   )..status = map['status'];
  // }
}
