import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/basic_question.dart';
import '../../models/complete_words_question.dart';
import '../../models/multipal_question.dart';
import '../../models/synonyms_question.dart';
import '../../models/words_in_order_question.dart';
import '../../models/yes_no_question.dart';

class QuestionsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addQuestion(BasicQuestion question) async {
    Map<String, dynamic> questionData = question.toJson();

    // Convert list of answers to a format suitable for Firestore
    if (question is MultipalQuestion) {
      questionData['answers'] =
          question.answers.map((a) => a.toJson()).toList();
    }

    if (question is YesNoQuestion) {
      questionData['wrongStep'] = question.wrongStep
          .toJson(); // נכון לעכשיו, זו קריאה לפונקציה על אובייקט ולא על Map
      questionData['correctStep'] = question.correctStep.toJson(); // כנ"ל
      questionData['wrongStep'] = question.wrongStep.toJson();
      questionData['correctStep'] = question.correctStep.toJson();
    }
    if (question is WordsInOrderQuestion) {
      questionData['randomOption'] = question.randomoptions.toJson();
    }
    await _db
        .collection('questions')
        .doc(question.numOfQuestion.toString())
        .set(questionData);
  }

  Future<BasicQuestion?> getQuestion(String id) async {
    final DocumentSnapshot<Map<String, dynamic>> doc;
    try {
      doc = await _db.collection('questions').doc(id).get();
    } catch (e) {
      print("Error getting question: $e");
      return null;
    }
    if (!doc.exists) {
      return null;
    }
    final data = doc.data();
    if (data == null) {
      return null;
    }
    return typeQuestion(data);
  }

  Future<Iterable<BasicQuestion>> getQuestions(
      String? grade, String? topic, int? amount, int? numOfBoard) async {
    try {
      QuerySnapshot snapshot = await _db.collection('questions').get();
      // Filter questions by grade and topic
      List<QueryDocumentSnapshot> filteredDocs = snapshot.docs.where((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<String> grades = List<String>.from(data['grades']) ?? [];
        String questionTopic = data['topic'] ?? '';
        return (grade == null || grades.contains(grade)) &&
            (topic == null || questionTopic == topic);
      }).toList();
      // Sort questions by ID
      filteredDocs.sort((a, b) {
        int idA = int.tryParse(a.id) ?? 0;
        int idB = int.tryParse(b.id) ?? 0;
        return idA.compareTo(idB);
      });

      // Calculate start index based on album and amount
      int startIndex = (numOfBoard ?? 0) * (amount ?? 0);
      List<QueryDocumentSnapshot> selectedDocs = [];

      // Ensure we have enough questions, wrapping around if necessary
      if (amount != null && filteredDocs.isNotEmpty) {
        for (int i = 0; i < amount; i++) {
          selectedDocs
              .add(filteredDocs[(startIndex + i) % filteredDocs.length]);
        }
      } else {
        selectedDocs = filteredDocs;
      }

      // Map documents to their IDs
      return selectedDocs
          .map((doc) => typeQuestion(doc.data() as Map<String, dynamic>));
    } catch (e) {
      print("Error getting questions: $e");
      return [];
    }
  }

  Future<void> deleteQuestion(String id) async {
    try {
      await _db.collection('questions').doc(id).delete();
      print("Question with ID $id deleted successfully.");
    } catch (e) {
      print("Error deleting question: $e");
    }
  }

  Future<void> updateQuestion(String id, BasicQuestion updates) async {
    try {
      await _db.collection('questions').doc(id).update(updates.toJson());
      print("Question with ID $id updated successfully.");
    } catch (e) {
      print("Error updating question: $e");
    }
  }

  Future<int> getHighestId() async {
    final querySnapshot = await _db
        .collection('questions')
        .orderBy('numOfQuestion', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String docId = querySnapshot.docs.first.id;
      // וודא שה-ID הוא מספרי
      if (int.tryParse(docId) != null) {
        return int.parse(docId);
      } else {
        print("Error: The ID is not a valid integer.");
        return 0;
      }
    } else {
      return 0;
    }
  }

  BasicQuestion typeQuestion(Map<String, dynamic> question) {
    switch (question['type']) {
      case 'complete_words':
        return CompleteWordsQuestion.fromJson(question);
      case 'multipal':
        return MultipalQuestion.fromJson(question);
      case 'synonyms':
        return SynonymsQuestion.fromJson(question);
      case 'words_in_order':
        return WordsInOrderQuestion.fromJson(question);
      case 'yes_no':
        return YesNoQuestion.fromJson(question);
      default:
        return BasicQuestion.fromJson(question);
    }
  }
}
