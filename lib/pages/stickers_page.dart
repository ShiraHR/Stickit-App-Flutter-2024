import 'package:flutter/material.dart';

import '../models/user.dart';

class StickersPage extends StatelessWidget {
  User user;

  final List<String> imageUrls = [
    'lib/images/sticker1.png',
    'lib/images/sticker2.png',
    'lib/images/sticker3.png',
  ];

  StickersPage({super.key, required this.user});

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
                "היי, ${user.firstName}${greeting} ",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              ClipOval(
                child: Image.network(
                  user.imageURL,
                  height: 20,
                  width: 20,
                ),
              ),
            ],
          ),
        ),
        body: _buildListTile());
  }

  Widget _buildListTile() {
    return SingleChildScrollView(
      child: Column(
        children: imageUrls.map((url) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: GestureDetector(
              onTap: () => print("Click"),
              child: Image.asset(
                url,
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
