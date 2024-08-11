import 'dart:io';
import 'package:final_project_3/models/random_options.dart';
import 'package:flutter/material.dart';
import '../../models/words_in_order_question.dart';
import '../../services/questions/questions_service.dart';
import '../component/question.dart';
import '../component/steps_input.dart';
import '../component/upload_image.dart';

class CreateWordInOrderQuestion extends StatefulWidget {
  @override
  _CreateWordInOrderQuestionState createState() =>
      _CreateWordInOrderQuestionState();
}

class _CreateWordInOrderQuestionState extends State<CreateWordInOrderQuestion> {
  final QuestionsService _questionService = QuestionsService();
  late List<String> words = [];
  File? _imageFile;
  String? _questionText;
  List<String> _selectedGrades = [];
  String? _selectedSkill;
  String? _selectedArea;
  String? _selectedLevel;
  List<int> _startNumbers = List.filled(4, 0);
  List<int> _endNumbers = List.filled(4, 0);

  @override
  void initState() {
    super.initState();
  }

  void _updateWords() {
    if (_questionText != null) {
      setState(() {
        words = _questionText!.split(' ');
      });
    }
  }

  Future<void> _submitQuestion() async {
    if (_imageFile == null ||
        _questionText == null ||
        _selectedSkill == null ||
        _selectedArea == null ||
        _startNumbers.length < 4 ||
        _endNumbers.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    WordsInOrderQuestion wordsInOrderQuestion =
        await WordsInOrderQuestion.createInstance(
            _imageFile!,
            _questionText!,
            _selectedSkill!,
            _selectedArea!,
            _selectedGrades,
            words,
            Randomoptions(
              noWrongAns:
                  StratEnd(start: _startNumbers[1], end: _endNumbers[1]),
              oneTwoWrongAns:
                  StratEnd(start: _startNumbers[2], end: _endNumbers[2]),
              threePlusTwoWrongAns:
                  StratEnd(start: _startNumbers[3], end: _endNumbers[3]),
            ));
    await _questionService.addQuestion(wordsInOrderQuestion);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Question Word in Order"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Question(
              onQuestionTextChanged: (text) {
                setState(() {
                  _questionText = text;
                  _updateWords();
                });
              },
              onSelectedClassesChanged: (selectedOptions) =>
                  setState(() => _selectedGrades = selectedOptions),
              onSelectedSkillChanged: (selectedOption) =>
                  setState(() => _selectedSkill = selectedOption),
              onSelectedAreaChanged: (selectedOption) =>
                  setState(() => _selectedArea = selectedOption),
              onSelectedLevelChanged: (selectedOption) =>
                  setState(() => _selectedLevel = selectedOption),
            ),
            Text("הסדר בו יוצג למשתמש"),
            _answerWordInOrder(),
            SizedBox(
              height: 20,
            ),
            Text("בלי שגיאות"),
            StepsInput(
              onStartNumberChanged: (text) =>
                  setState(() => _startNumbers[1] = text),
              onEndNumberChanged: (text) =>
                  setState(() => _endNumbers[1] = text),
            ),
            Text("בין 1 ל2 טעיות"),
            StepsInput(
              onStartNumberChanged: (text) =>
                  setState(() => _startNumbers[2] = text),
              onEndNumberChanged: (text) =>
                  setState(() => _endNumbers[2] = text),
            ),
            Text("מעל 3 טעויות"),
            StepsInput(
              onStartNumberChanged: (text) =>
                  setState(() => _startNumbers[3] = text),
              onEndNumberChanged: (text) =>
                  setState(() => _endNumbers[3] = text),
            ),
            SizedBox(
              height: 20,
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

  Widget _answerWordInOrder() {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List.generate(
            words.length,
            (index) {
              return Draggable<String>(
                data: words[index],
                feedback: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IntrinsicWidth(
                      child: IntrinsicHeight(
                        child: Center(
                          child: Text(words[index]),
                        ),
                      ),
                    ),
                  ),
                ),
                childWhenDragging: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IntrinsicWidth(
                    child: IntrinsicHeight(
                      child: Center(
                        child: Text(words[index]),
                      ),
                    ),
                  ),
                ),
                child: DragTarget<String>(
                  onAccept: (data) {
                    setState(() {
                      int oldIndex = words.indexOf(data);
                      String item = words.removeAt(oldIndex);
                      words.insert(index, item);
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IntrinsicWidth(
                        child: IntrinsicHeight(
                          child: Center(
                            child: Text(words[index]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
