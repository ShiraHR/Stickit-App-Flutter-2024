import 'package:final_project_3/pages/album_page.dart';
import 'package:final_project_3/pages/questions/generic_quesyion_page.dart';
import 'package:flutter/material.dart';

import '../components/wide_button.dart';
import '../models/user.dart';

class EndGamePage extends StatelessWidget {
  final User user;
  const EndGamePage({Key? key, required this.user}) : super(key: key);

  void _handleSubmit(BuildContext context) {
    user.finishBoard();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GenericQuesyionPage(
          user: user,
          question: user.gameBoard.questions[0],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congratulations, ${user.firstName}! You won the game in ${user.gameBoard.numOfMoves} steps!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            WideButton(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlbumPage(user: user)
                  ),
                )
              },
              text: 'go to album',
            ),
            WideButton(
              onTap: () => _handleSubmit(context),
              text: 'Start New Game',
            ),
          ],
        ),
      ),
    );
  }
}
