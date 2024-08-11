import 'package:flutter/material.dart';

class QuestionsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int numOfBoard;
  final int questionsAnswered;
  final int totalQuestions;

  QuestionsAppBar({
      this.numOfBoard = 1,
      this.questionsAnswered = 1,
      this.totalQuestions = 10
      });

  @override
  Size get preferredSize => const Size.fromHeight(162.0); // Set height to 162

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'לוח #${numOfBoard}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      "lib/images/game_name.png",
                      height: 33,
                      width: 120,
                    ),
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_right, size: 24),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ]),
              SizedBox(
                height: 48,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "שאלה מס' ${questionsAnswered}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 210,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          width: 210 * (questionsAnswered / totalQuestions),
                          height: 6,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        toolbarHeight: 162.0, // Set the toolbar height to 162
      ),
    );
  }
}
