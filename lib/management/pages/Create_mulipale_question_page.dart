import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/answer.dart';
import '../../models/multipal_question.dart';
import '../../services/questions/questions_service.dart';
import '../component/answer.dart';
import '../component/question.dart';
import '../component/upload_image.dart';

class CreateMultipleQuestionPage extends StatefulWidget {
  @override
  _CreateMultipleQuestionPageState createState() =>
      _CreateMultipleQuestionPageState();
}

class _CreateMultipleQuestionPageState
    extends State<CreateMultipleQuestionPage> {
  final QuestionsService _questionService = QuestionsService();
  List<Answer> _answers = [];
  File? _imageFile;
  String? _questionText;
  List<String> _selectedGrades = [];
  String? _selectedSkill;
  String? _selectedArea;
  String? _selectedLevel;

  Future<void> _submitQuestion() async {
    if (_questionText == null ||
        _selectedSkill == null ||
        _selectedArea == null ||
        _selectedGrades.isEmpty ||
        _answers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
   
for (Answer answer in _answers) {
  // אם qeyWord הוא nullable
  if (answer.qeyWord == null) {
    answer.qeyWord = _selectedSkill!;
  }
}
print(_answers);
    MultipalQuestion question = await MultipalQuestion.createInstance(
        _imageFile!,
        _questionText!,
        _selectedSkill!,
        _selectedArea!,
        _selectedGrades,
        _answers);

    await _questionService.addQuestion(question);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Question added successfully')),
    );

    _clearFields();
  }

  void _clearFields() {
    setState(() {
      _questionText = null;
      _selectedGrades = [];
      _selectedSkill = null;
      _selectedArea = null;
      _selectedLevel = null;
      _imageFile = null;
      _answers = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Multiple Select Question"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Question(
              onQuestionTextChanged: (text) =>
                  setState(() => _questionText = text),
              onSelectedClassesChanged: (selectedOptions) =>
                  setState(() => _selectedGrades = selectedOptions),
              onSelectedSkillChanged: (selectedOption) =>
                  setState(() => _selectedSkill = selectedOption),
              onSelectedAreaChanged: (selectedOption) =>
                  setState(() => _selectedArea = selectedOption),
              onSelectedLevelChanged: (selectedOption) =>
                  setState(() => _selectedLevel = selectedOption),
            ),
            const SizedBox(height: 16),
            AnswerSelect(
                initialAnswers: _answers,
                onAnswersChanged: (_answers) =>
                    setState(() => _answers = _answers)),
            const SizedBox(height: 16),
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
