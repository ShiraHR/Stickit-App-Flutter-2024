// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      grade: json['grade'] as String,
      joiningDate: json['joiningDate'] as String,
      imageURL: json['imageURL'] as String,
      album: Album.fromJson(json['album'] as Map<String, dynamic>),
      gameBoard: GameBoard.fromJson(json['gameBoard'] as Map<String, dynamic>),
      boardNumber: (json['boardNumber'] as num?)?.toInt() ?? 0,
      silverStickers: (json['silverStickers'] as num?)?.toInt() ?? 0,
      goldStickers: (json['goldStickers'] as num?)?.toInt() ?? 0,
      answeredQuestions: (json['answeredQuestions'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    )..finishedAlbums = (json['finishedAlbums'] as List<dynamic>)
        .map((e) => e as String)
        .toList();

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'grade': instance.grade,
  'joiningDate': instance.joiningDate,
  'imageURL': instance.imageURL,
  'boardNumber': instance.boardNumber,
  'album': instance.album?.toJson(), // Assuming 'album' is an object, so we call 'toJson'
  'gameBoard': instance.gameBoard.toJson(), // Assuming 'gameBoard' is an object, so we call 'toJson'
  'finishedAlbums': instance.finishedAlbums, // This is a List<String>, no need for 'toJson'
  'silverStickers': instance.silverStickers,
  'goldStickers': instance.goldStickers,
  'answeredQuestions': instance.answeredQuestions,
};