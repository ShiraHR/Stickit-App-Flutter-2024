import 'package:final_project_3/models/basic_question.dart';
import 'package:final_project_3/services/board_service.dart';
import 'package:final_project_3/services/questions/questions_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_board.g.dart';

@JsonSerializable()
class GameBoard {
  static final QuestionsService _questionsServices = QuestionsService();
  static final BoardService _boardService = BoardService();
  late String id;
  final String grade;
  final int numOfQuestions;
  List<BasicQuestion> questions;
  int currentQuestion;
  int numOfMoves;
  List<bool> answered;
  final int goldStickers;
  final int silverStickers;

  GameBoard({
    required this.id, // Ensure 'id' is required and passed during construction
    required this.grade,
    required this.numOfQuestions,
    required this.goldStickers,
    required this.silverStickers,
    required this.questions,
    required this.currentQuestion,
    required this.numOfMoves,
    required this.answered,
  });

  static Future<GameBoard> create({
    required String grade,
    required List<String> subjects,
    int numOfQuestions = 10,
    int currentQuestion = 0,
    int numOfMoves = 0,
    required int goldStickers,
    required int silverStickers,
    required int numOfAlbum,
  }) async {
    List<BasicQuestion> questions = [];
    for (String s in subjects) {
      questions.addAll(await _questionsServices.getQuestions(
          grade, s, numOfQuestions ~/ subjects.length, numOfAlbum));
    }
    List<bool> answered = List<bool>.filled(questions.length, false);

    // Generate a new ID here before creating the board
    String id = _boardService.db.collection('boards').doc().id;

    final board = GameBoard(
      id: id, // Set the generated ID here
      grade: grade,
      numOfQuestions: questions.length,
      goldStickers: goldStickers,
      silverStickers: silverStickers,
      questions: questions,
      currentQuestion: currentQuestion,
      numOfMoves: numOfMoves,
      answered: answered,
    );

    // Add the board to Firestore
    await _boardService.addGameBoard(board);

    return board;
  }

  factory GameBoard.fromJson(Map<String, dynamic> json) =>
      _$GameBoardFromJson(json);

  Map<String, dynamic> toJson() => _$GameBoardToJson(this);

  BasicQuestion startGame(int currentQuestion) {
    return questions[currentQuestion];
  }

  BasicQuestion getCurrentQuestion(){
    return questions[currentQuestion];
  }

  bool isGameOver(int questionNum) {
    return questionNum >= numOfQuestions - 1;
  }

  int stepSize(int questionNum, int step) {
    print("********************************* next question step size");
    int nextQuestion = questionNum + step;
    if (nextQuestion < questions.length && nextQuestion >= 0) {
      return nextQuestion;
    } else if (nextQuestion >= questions.length) {
      return questions.length - 1;
    } else {
      return 0;
    }
  }

  int checkWhichQuestion(int questionNum, int step) {
    print("********************************* next question checkWhichQuestion");
    int nextQuestionNum = stepSize(questionNum, step);
    print('******************************** nextQuestionNum: $nextQuestionNum');
    if (step > 0) {
      for (int i = nextQuestionNum;
          i > questionNum && i > 0;
          i--) {
            print('i: $i');
        if (!answered[i]) {
          return i;
        }
      }
      return nextQuestionNum;
    }
    for (int i = nextQuestionNum; i < questionNum && i < questions.length; i++) {
      if (!answered[i]) {
        return i;
      }
    }
    print('******************************** nextQuestionNum: $nextQuestionNum');
    return nextQuestionNum;
  }

  int positiveOrNegativeStep(int step, bool nextOrPrev) {
    return nextOrPrev ? step : -step;
  }

  GameBoard nextQuestion(int questionNum, bool nextOrPrev, int step) {
    numOfMoves++;
    int transformedStep = positiveOrNegativeStep(step, nextOrPrev);
    int nextQuestionIndex = checkWhichQuestion(questionNum, transformedStep);
    currentQuestion = nextQuestionIndex;
    answered[questionNum] = true;
    // _boardService.update(id, {
    //   "numOfMoves": numOfMoves,
    //   "currentQuestion": currentQuestion,
    //   "answered": answered,
    // });
    return this;
  }
}
