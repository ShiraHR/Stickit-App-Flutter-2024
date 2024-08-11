import 'package:flutter/material.dart';
import '../components/wide_button.dart';
import '../models/user.dart';
import 'about_page.dart';
import 'login_page_one.dart';
import 'navigation_dropdown.dart';
import 'navigation_page.dart';

class ReadyScreen extends StatelessWidget {
  final User user;
ReadyScreen({required this.user ,super.key}){
    print('users email: ${user.email}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Image.asset(
                  'lib/images/game_name.png',
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.all(25),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                _drawerInfo(
                  Icons.info,
                  'About',
                  () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutPage()));
                  },
                ),
                
                if (user.email == 'ruti4293@gmail.com')
                  _drawerInfoWithDropdown(
                      Icons.manage_accounts, 'Manage Products'),
              ],
            ),
            _drawerInfo(
              Icons.logout,
              'Logout',
              () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Stack(
              children: [
                Positioned(
                  child: Image.asset(
                    './lib/images/planet.png',
                    alignment: AlignmentDirectional.topEnd,
                    height: 300,
                  ),
                ),
                Positioned(
                  top: 85,
                  left: 79,
                  child: Image.asset(
                    './lib/images/game_name.png',
                    alignment: Alignment.center,
                    width: 200,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(
              './lib/images/home.png',
              height: 400,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Center(
            child: Text(
              'הי ${user.firstName} כיף שהצטרפת, \n הפרופיל שלך מוכן, אפשר כבר להתחיל...',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          WideButton(
            text: 'למסך הראשי',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NavigationPage(
                            user: user,
                          )));
            },
            color: 'yellow',
          )
        ],
      ),
    );
  }

  Widget _drawerInfo(IconData icon, String text, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: ListTile(
          leading: Icon(icon),
          title: Text(text),
        ),
      ),
    );
  }

  Widget _drawerInfoWithDropdown(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          NavigationDropdown(
            user: user,
          ),
        ],
      ),
    );
  }
}
