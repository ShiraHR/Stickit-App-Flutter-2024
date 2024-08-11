import 'package:final_project_3/management/component/one_answer.dart';
import 'package:flutter/material.dart';
import '../../components/true_false_button.dart';
import '../../models/answer.dart';
import '../../models/random_options.dart';
import 'steps_input.dart';
import 'text_filed.dart';

class AnswerSelect extends StatefulWidget {
  final List<Answer> initialAnswers;
  final ValueChanged<List<Answer>> onAnswersChanged;

  const AnswerSelect(
      {super.key,
      required this.initialAnswers,
      required this.onAnswersChanged});

  @override
  _AnswerSelectState createState() => _AnswerSelectState();
}

class _AnswerSelectState extends State<AnswerSelect> {
  // late List<TextEditingController> _controllers;
  // late List<TextEditingController> _classificationControllers;
  late List<Answer> _answers;

  @override
  void initState() {
    super.initState();
    _answers = widget.initialAnswers;
    // _controllers = _answers
    //     .map((answer) => TextEditingController(text: answer.answer))
    //     .toList();
    // _classificationControllers =
    //     _answers.map((answer) => TextEditingController()).toList();
  }

  // @override
  // void dispose() {
  //   for (var controller in _controllers) {
  //     controller.dispose();
  //   }
  //   for (var controller in _classificationControllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }

  void _addAnswer() {
    print("addAnswer");
    setState(() {
      if (_answers.length < 5) {
        _answers.add(Answer(
          answer: '',
          classification: false,
          step: StratEnd(start: 0, end: 0),
          qeyWord: '',
        ));
        // _controllers.add(TextEditingController());
        // _classificationControllers.add(TextEditingController());
        _notifyAnswersChanged();
      }
    });
  }

  void _removeAnswer(int index) {
    setState(() {
      if (_answers.length > 1) {
        _answers.removeAt(index);
        // _controllers[index].dispose();
        // _controllers.removeAt(index);
        // _classificationControllers[index].dispose();
        // _classificationControllers.removeAt(index);
        _notifyAnswersChanged();
      }
    });
  }

  void _notifyAnswersChanged() {
    widget.onAnswersChanged(_answers);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400.0, // Set a fixed height for the list
          child: ListView.builder(
            itemCount: _answers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => _removeAnswer(index),
                    ),
                    Expanded(
                      child: OneAnswer(
                        initialAnswer: _answers[index],
                        onAnswerChanged: (answer) => setState(() {
                          _answers[index] = answer;
                        }),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: _addAnswer,
          child: const Text("הוסף תשובה"),
        ),
      ],
    );
  }
}
