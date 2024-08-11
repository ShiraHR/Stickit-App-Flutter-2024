import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../components/true_false_button.dart';
import '../../models/random_options.dart';
import '../../models/yes_no_question.dart';
import '../../services/questions/questions_service.dart';
import '../component/steps_input.dart';
import '../component/question.dart';
import '../component/upload_image.dart';

class CreateBooleanQuestionPage extends StatefulWidget {
  const CreateBooleanQuestionPage({super.key});

  @override
  _CreateBooleanQuestionPageState createState() => _CreateBooleanQuestionPageState();
}

class _CreateBooleanQuestionPageState extends State<CreateBooleanQuestionPage> {
  final QuestionsService _questionService = QuestionsService();

  bool? _answer;
  File? _imageFile;
  String? _questionText;
  List<String> _selectedGrades = [];
  String? _selectedSkill;
  String? _selectedArea;
  String? _selectedLevel;
  late int _startNumber = 0;
  late int _endNumber = 0;
  late int _endNumber2 = 0;
  late int _startNumber2 = 0;

  Future<void> _submitQuestion() async {
    print(_selectedGrades);
    print(_selectedSkill);

    if (_questionText == null || _selectedSkill == null || _selectedArea == null || _selectedGrades.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      YesNoQuestion yesNoQuestion = await YesNoQuestion.createInstance(
        _imageFile!,
        _questionText!,
        _selectedSkill!,
        _selectedArea!,
        _selectedGrades,
        _answer!,
        StratEnd(start: _startNumber, end: _endNumber),
        StratEnd(start: _startNumber2, end: _endNumber2)
      );

      await _questionService.addQuestion(yesNoQuestion);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Question added successfully')),
      );

      _clearFields();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add question: $e')),
      );

      print(e);
    }
  }

  void _clearFields() {
    setState(() {
      _questionText = null;
      _answer = null;
      _selectedGrades = [];
      _selectedSkill = null;
      _selectedArea = null;
      _selectedLevel = null;
      _imageFile = null;
    });
  }

  void _handleNumberChange(String text, ValueChanged<int> onChanged) {
    try {
      int value = int.parse(text);
      if (value < 0 || value > 4294967296) {
        throw RangeError('Value must be between 1 and 4294967296');
      }
      onChanged(value);
    } catch (e) {
      // Handle the error appropriately (e.g., show an error message)
      print('Error parsing number: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Boolean Question'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Question(
              onQuestionTextChanged: (text) => setState(() => _questionText = text),
              onSelectedClassesChanged: (selectedOptions) => setState(() => _selectedGrades = selectedOptions),
              onSelectedSkillChanged: (selectedOption) => setState(() => _selectedSkill = selectedOption),
              onSelectedAreaChanged: (selectedOption) => setState(() => _selectedArea = selectedOption),
              onSelectedLevelChanged: (selectedOption) => setState(() => _selectedLevel = selectedOption),
            ),
            SizedBox(height: 20),
            Text("התשובה :"),
            SizedBox(height: 20),
            Row(children: [
              TrueOrFalseButton(
                isTrue: true,
                onTap: () {
                  setState(() {
                    _answer = true;
                  });
                },
              ),
              SizedBox(width: 20),
              TrueOrFalseButton(
                isTrue: false,
                onTap: () {
                  setState(() {
                    _answer = false;
                  });
                },
              ),
            ]),
            SizedBox(height: 20),
            if (_answer != null) Text('התשובה שנבחרה: $_answer'),
            Text("טווח הקפיצות לתשובה נכונה"),
            StepsInput(
              onStartNumberChanged: (text) => setState(() => _startNumber = text),
              onEndNumberChanged: (text) => setState(() => _endNumber = text),
            ),
            Text("טווח הקפיצות לתשובה שגויה"),
            StepsInput(
              onStartNumberChanged: (text) => setState(() => _startNumber2 = text),
              onEndNumberChanged: (text) => setState(() => _endNumber2 = text),
            ),
            ImagePickerWidget(
              initialImage: _imageFile,
              onImagePicked: (image) {
                setState(() {
                  _imageFile = image;
                });
              },
            ),
            ElevatedButton(
              onPressed: _submitQuestion,
              child: const Text("Create"),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addQuestion(YesNoQuestion question) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('questions').add(question.toJson());
    } else {
      throw Exception('User not authenticated');
    }
  }
}
