import 'package:final_project_3/management/pages/Create_boolean_question_page.dart';
import 'package:final_project_3/management/pages/Create_mulipale_question_page.dart';
import 'package:final_project_3/management/pages/Create_word_in_order_question.dart';
import 'package:final_project_3/pages/ready_screen.dart';
import 'package:flutter/material.dart';

import '../management/pages/Create_one answer_corect_question.dart';
import '../models/user.dart';

class NavigationDropdown extends StatefulWidget {
  final User user;
  NavigationDropdown({required this.user});
  @override
  _NavigationDropdownState createState() => _NavigationDropdownState(user: user);
}

class _NavigationDropdownState extends State<NavigationDropdown> {
  String? _selectedPage;
  final User user;
  _NavigationDropdownState({required this.user});
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text('איזה סוג שאלה תרצה/י להוסיף?'),
      value: _selectedPage,
      onChanged: (String? newValue) {
        setState(() {
          _selectedPage = newValue;
        });
        if (newValue != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => getPage(newValue)),
          );
        }
      },
      items: const <DropdownMenuItem<String>>[
        DropdownMenuItem<String>(
          value: 'boolean',
          child: Text('נכון/לא נכון'),
        ),
        DropdownMenuItem<String>(
          value: 'oneAnswer',
          child: Text('תשובה אחת נכונה'),
        ),
        DropdownMenuItem<String>(
          value: 'multiAnswer',
          child: Text('כמה תשובות נכונות'),
        ),
        DropdownMenuItem<String>(
          value: 'arrangementOfASentence',
          child: Text('סידור משפט'),
        ),
      ],
    );
  }

  Widget getPage(String page) {
    switch (page) {
      case 'boolean':
        return CreateBooleanQuestionPage();//CreateBooleanQuestionPage  אמור להוביל לדף של נכון/לא נכון
      case 'oneAnswer':
        return CreateOneCorectQuestionPage(); // אמור להוביל לדף של תשובה אחת נכונה
      case 'multiAnswer':
        return CreateMultipleQuestionPage(); // אמור להוביל לדף של כמה תשובות נכונות
      case 'arrangementOfASentence':
        return CreateWordInOrderQuestion(); // אמור להוביל לדף של סידור משפט
      default:
        return ReadyScreen(user: user);// אמורים לגלגל לפה את הנתונים מה login
    }
  }
}
