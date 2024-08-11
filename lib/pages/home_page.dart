import 'package:final_project_3/models/basic_question.dart';
import 'package:final_project_3/pages/questions/generic_quesyion_page.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class HomePage extends StatelessWidget {
  final User user;
  HomePage({required this.user, super.key});
  final List<String> imageUrls = [
    'lib/images/home1.png',
    'lib/images/home2.png',
    'lib/images/home3.png',
    'lib/images/home4.png',
  ];
  final List<Color> colorUrls = [
    const Color(0xFF69E7AA),
    const Color(0xfff2d88a),
    const Color(0xFF74D7D6),
    const Color(0xFFADB4FF),
  ];

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'בוקר טוב';
    } else if (hour < 19) {
      return 'צהריים טובים';
    } else {
      return 'לילה טוב';
    }
  }

  int saveCurrentBoardNumber() {
    return user.boardNumber;
  }


  @override
  Widget build(BuildContext context) {
    String greeting = _getGreeting();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              "lib/images/game_name.png",
              height: 33,
              width: 120,
            ),
            Text(
              "היי, ${user.firstName} ${greeting} ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            ClipOval(
              child: Image.network(
                user.imageURL,
                height: 10,
                width: 10,
              ),
            ),
          ],
        ),
      ),
      body: _buildListTile(context),
    );
  }

  Widget _buildListTile(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: imageUrls.asMap().entries.map((entry) {
          int index = entry.key;
          String url = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                GestureDetector(
                  onTap: () => print("Image Clicked"),
                  child: Image.asset(
                    url,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: -20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: _buildFloatingButton(context, index, user)
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

   Widget _buildFloatingButton(
    BuildContext context, int index, User user) {
    return FloatingActionButton(
      onPressed: () {
        if(index == user.boardNumber){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GenericQuesyionPage(
              user: user,
              question: user.gameBoard.startGame(user.gameBoard.currentQuestion),
            ),
          ),
        );
        }
      },
      backgroundColor: colorUrls[index],
      child:
      index == user.boardNumber?
       Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ):Icon(
        Icons.lock,
        color: Colors.white,
      ),

      elevation: 6.0, // Button shadow
      shape: CircleBorder(
        side: BorderSide(
          color: Colors.white,
          width: 3,
        ),
      ),
    );
  }
}
