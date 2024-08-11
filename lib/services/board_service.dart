import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_3/models/game_board.dart';

class BoardService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addGameBoard(GameBoard board) async {
    try {
      DocumentReference docRef = db.collection('boards').doc(board.id);
      print(board.toJson());
      await docRef.set(board.toJson());
      print('Board added successfully with ID: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      print('Failed to add board: $e');
      return '';
    }
  }

  Future<GameBoard> update(String id, Map<String, dynamic> data) async {
    try {
      final DocumentReference docRef = db.collection('boards').doc(id);
      await docRef.update(data);
      final DocumentSnapshot docSnapshot = await docRef.get();
      return GameBoard.fromJson(docSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print('Failed to update board: $e');
      rethrow;
    }
  }

  Future<void> deleteBoard(String id) async {
    try {
      await db.collection('boards').doc(id).delete();
      print('Board with ID: $id deleted successfully.');
    } catch (e) {
      print('Failed to delete board: $e');
    }
  }
}
