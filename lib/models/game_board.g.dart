// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameBoard _$GameBoardFromJson(Map<String, dynamic> json) => GameBoard(
      id: json["id"] as String,
      grade: json['grade'] as String, 
      numOfQuestions: (json['numOfQuestions'] as num).toInt(),
      goldStickers: (json['goldStickers'] as num).toInt(),
      silverStickers: (json['silverStickers'] as num).toInt(),
      questions: (json['questions'] as List<dynamic>)
          .map((e) =>QuestionsService().typeQuestion(e as Map<String, dynamic>))
          .toList(),
      currentQuestion: (json['currentQuestion'] as num).toInt(),
      numOfMoves: (json['numOfMoves'] as num).toInt(),
      answered:
          (json['answered'] as List<dynamic>).map((e) => e as bool).toList(),
    );

Map<String, dynamic> _$GameBoardToJson(GameBoard instance) => <String, dynamic>{
      'grade': instance.grade,
      'numOfQuestions': instance.numOfQuestions,
      'questions': instance.questions.map((q) => q.toJson()).toList(),
      'currentQuestion': instance.currentQuestion,
      'numOfMoves': instance.numOfMoves,
      'answered': instance.answered,
      'goldStickers': instance.goldStickers,
      'silverStickers': instance.silverStickers,
    };
