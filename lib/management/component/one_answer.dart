import 'package:flutter/material.dart';
import '../../components/true_false_button.dart';
import '../../models/answer.dart';
import '../../models/random_options.dart';
import 'steps_input.dart';
import 'text_filed.dart';

class OneAnswer extends StatefulWidget {
  final Answer initialAnswer;
  final ValueChanged<Answer> onAnswerChanged;

  const OneAnswer({
    super.key,
    required this.initialAnswer,
    required this.onAnswerChanged,
  });

  @override
  _OneAnswerState createState() => _OneAnswerState();
}

class _OneAnswerState extends State<OneAnswer> {
  late TextEditingController _controller;
  late Answer _answer; // Added _answer here
  late bool _classification; // Track classification as a bool

  @override
  void initState() {
    super.initState();
    _answer = widget.initialAnswer;
    _controller = TextEditingController(text: _answer.answer);
    _classification = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _notifyAnswerChanged() {
    widget.onAnswerChanged(_answer);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GenericTextInput(
          hintText: "תוכן התשובה",
          controller: _controller,
          onChanged: (text) {
            setState(() {
              _answer = Answer(
                answer: text,
                classification: _answer.classification,
                step: _answer.step,
                qeyWord: _answer.qeyWord,
              );
              _notifyAnswerChanged();
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        TrueOrFalseButton(
          isTrue: true,
          onTap: () => {
            print(_classification),
            setState(() {
              _classification = ! _classification;
              _answer = Answer(
                answer: _answer.answer,
                classification: _classification,
                step: _answer.step,
                qeyWord: _answer.qeyWord,
              );
            }),
            _notifyAnswerChanged()
          },
        ),
        StepsInput(
          onStartNumberChanged: (int value) {
            setState(() {
              _answer = Answer(
                answer: _answer.answer,
                classification: _answer.classification,
                step: StratEnd(start: value, end: _answer.step.end),
                qeyWord: _answer.qeyWord,
              );
              _notifyAnswerChanged();
            });
          },
          onEndNumberChanged: (int value) {
            setState(() {
              _answer = Answer(
                answer: _answer.answer,
                classification: _answer.classification,
                step: StratEnd(start: _answer.step.start, end: value),
                qeyWord: _answer.qeyWord,
              );
              _notifyAnswerChanged();
            });
          },
        ),
      ],
    );
  }
}
