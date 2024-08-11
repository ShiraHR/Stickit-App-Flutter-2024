import 'package:flutter/material.dart';
import '../system_setting_models/model.dart';
import 'dropDown.dart';
import 'multySelectDropDown.dart';
import 'text_filed.dart';

class Question extends StatefulWidget {
  final ValueChanged<String>? onQuestionTextChanged;
  final ValueChanged<List<String>>? onSelectedClassesChanged;
  final ValueChanged<String?>? onSelectedSkillChanged;
  final ValueChanged<String?>? onSelectedAreaChanged;
  final ValueChanged<String?>? onSelectedLevelChanged;

  Question({
    this.onQuestionTextChanged,
    this.onSelectedClassesChanged,
    this.onSelectedSkillChanged,
    this.onSelectedAreaChanged,
    this.onSelectedLevelChanged,
  });

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final TextEditingController _questionController = TextEditingController();
  List<String> _selectedClasses = [];
  String? _selectedSkill;
  String? _selectedArea;
  String? _selectedLevel;

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Classes schoolClasses = Classes();
    List<String> classList = schoolClasses.getClasses();
    QuestionLevels levels = QuestionLevels();
    List<String> levelList = levels.getQuestionLevels();
    TeachingAreas areas = TeachingAreas();
    List<String> areaList = areas.getTeachingAreas();
    Skills skills = Skills();
    List<String> skillsList = skills.getSkills();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GenericTextInput(
            hintText: 'השאלה :',
            controller: _questionController,
            onChanged: (text) {
              if (widget.onQuestionTextChanged != null) {
                widget.onQuestionTextChanged!(text);
              }
            },
          ),
          SizedBox(height: 20),
          GenericMultiSelectDropdown(
            hint: 'בחר כיתה',
            options: classList,
            selectedOptions: _selectedClasses,
            onChanged: (selectedOptions) {
              setState(() {
                _selectedClasses = selectedOptions;
              });
              if (widget.onSelectedClassesChanged != null) {
                widget.onSelectedClassesChanged!(_selectedClasses);
              }
            },
          ),
          SizedBox(height: 20),
          GenericDropdown(
            hint: 'בחר מיומנויות',
            options: skillsList,
            selectedOption: _selectedSkill,
            onChanged: (selectedOption) {
              setState(() {
                _selectedSkill = selectedOption;
              });
              if (widget.onSelectedSkillChanged != null) {
                widget.onSelectedSkillChanged!(_selectedSkill);
              }
            },
          ),
          SizedBox(height: 20),
          GenericDropdown(
            hint: 'בחר תחום',
            options: areaList,
            selectedOption: _selectedArea,
            onChanged: (selectedOption) {
              setState(() {
                _selectedArea = selectedOption;
              });
              if (widget.onSelectedAreaChanged != null) {
                widget.onSelectedAreaChanged!(_selectedArea);
              }
            },
          ),
          SizedBox(height: 20),
          GenericDropdown(
            hint: 'בחר דרגת קושי',
            options: levelList,
            selectedOption: _selectedLevel,
            onChanged: (selectedOption) {
              setState(() {
                _selectedLevel = selectedOption;
              });
              if (widget.onSelectedLevelChanged != null) {
                widget.onSelectedLevelChanged!(_selectedLevel);
              }
            },
          ),
        ],
      ),
    );
  }
}
