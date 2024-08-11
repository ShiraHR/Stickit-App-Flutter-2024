import 'dart:io';

import 'package:final_project_3/management/system_setting_models/model.dart';
import 'package:final_project_3/models/album.dart';
import 'package:final_project_3/models/game_board.dart';
import 'package:final_project_3/services/album_service.dart';
import 'package:final_project_3/services/user_service.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../services/board_service.dart';
import '../services/image_service.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  static final ImageService _imageService = ImageService();
  static final UserService _userService = UserService();
  static final AlbumService _albumService = AlbumService();
  static final BoardService _boardService = BoardService();
  final String email;
  String firstName;
  String lastName;
  String grade;
  final String joiningDate;
  String imageURL;
  int boardNumber;
  Album? album;
  GameBoard gameBoard;
  List<String> finishedAlbums = [];
  // List<bool> openedStickers;
  int silverStickers;
  int goldStickers;
  List<int> answeredQuestions;

  User(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.grade,
      required this.joiningDate,
      required this.imageURL,
      required this.album,
      required this.gameBoard,
      this.boardNumber = 0,
      this.silverStickers = 0,
      this.goldStickers = 0,
      required this.answeredQuestions,
      // required this.openedStickers
      });

  static Future<User> create(
      {required String email,
      required String firstName,
      required String lastName,
      required String grade,
      required File image,
      int numOfQuestions = 10}) async {
    String imageURL = await _imageService.uploadImage(image);
    Album? album = await _albumService.getAlbum('1');//Album(name: "", numOfSilverStickers: 0, numOfGoldStickers: 0, date: '', status: Status.dispalyedAvailible, stickers: [], numOfAlbum: 1);
    List<String> subjects = TeachingAreas().getTeachingAreas();
    // List<String> subjects = ["Math", "Englis'h"];
    GameBoard gameBoard = await GameBoard.create(
      grade: grade,
      subjects: subjects,
      numOfQuestions: numOfQuestions,
      goldStickers: 1,
      silverStickers: 2,
      numOfAlbum: 1,
    );
    List<int> answeredQuestions = [];
    final user = User(
      email: email,
      firstName: firstName,
      lastName: lastName,
      grade: grade,
      joiningDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      imageURL: imageURL,
      album: album,
      gameBoard: gameBoard,
      answeredQuestions: answeredQuestions,
    );
    print(user);
    _userService.addUser(user);
    return user;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  void setImage(File? image) async {
  if (image == null) {
    return;
  }
  String imageURL = await _imageService.uploadImage(image);
  await _userService.update(email, {"imageURL": imageURL});
}
  void setName(String firstName, String lastName) async {
    if (firstName.isEmpty || lastName.isEmpty) {
      throw Exception('First name and last name cannot be empty.');
    }
    this.firstName = firstName;
    this.lastName = lastName;
    _userService.update(email, {"firstName": firstName, "lastName": lastName});
  }

  void setGrade(String grade) async {
    if (grade.isEmpty) {
      throw Exception('Grade cannot be empty.');
    }
    this.grade = grade;
    _userService.update(email, {"grade": grade});
  }

  void finishBoard() async {
    boardNumber++;
    silverStickers += this.gameBoard.silverStickers;
    goldStickers += this.gameBoard.goldStickers;
    List<String> subjects = ["Math", "English"];
    GameBoard gameBoard = await GameBoard.create(
      grade: grade,
      subjects: subjects,
      goldStickers: 1,
      silverStickers: 2,
      numOfAlbum: boardNumber,
    );
    this.gameBoard = gameBoard;
    finishAlbum();
    _userService.update(email, {
      "boardNumber": boardNumber,
      "gameBoard": gameBoard.toJson(),
      "silverStickers": silverStickers,
      "goldStickers": goldStickers,
    });
    _boardService.deleteBoard(gameBoard.id);
  }

  // void openStickers() {
  //   int gold = this.gameBoard.goldStickers;
  //   int silver = this.gameBoard.silverStickers;
  //   for (Sticker sticker in album.stickers) {
  //     if (silver == 0 && gold == 0) {
  //       return;
  //     } else {
  //       if (!openedStickers[album.stickers.indexOf(sticker)]) {
  //         if (sticker.type == 'gold' && gold > 0) {
  //           openedStickers[album.stickers.indexOf(sticker)] = true;
  //           gold--;
  //         } else {
  //           if (sticker.type == 'silver' && silver > 0) {
  //             openedStickers[album.stickers.indexOf(sticker)] = true;
  //             silver--;
  //           } else {
  //             continue;
  //           }
  //         }
  //       }
  //     }
  //   }
  //   _userService.update(email, {"openedStickers": openedStickers});
  // }

  void finishAlbum() async {
    if (silverStickers >= album!.numOfSilverStickers &&
        goldStickers >= album!.numOfGoldStickers) {
      finishedAlbums.add(album!.name);
      silverStickers -= album!.numOfSilverStickers;
      goldStickers -= album!.numOfGoldStickers;
      while (finishedAlbums.contains(album!.name)) {
        album = await _albumService.getRandomAlbum();
      }
      _userService.update(email, {
        "album": album!.toJson(),
        "finishedAlbums": finishedAlbums,
        "silverStickers": silverStickers,
        "goldStickers": goldStickers
      });
    }
  }

  void updateAmswers() {
    answeredQuestions
        .add(gameBoard.questions[gameBoard.currentQuestion].numOfQuestion);
    _userService.update(email, {"answeredQuestions": answeredQuestions});
  }

  void nextQuestion(int questionNum, bool nextOrPrev, int step) async {
    gameBoard = gameBoard.nextQuestion(questionNum, nextOrPrev, step);
    await _userService.update(email, {"gameBoard": gameBoard.toJson()});
  }
}
