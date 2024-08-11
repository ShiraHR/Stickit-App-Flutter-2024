import 'package:final_project_3/components/bottom_nav_bar.dart';
import 'package:final_project_3/pages/home_page.dart';
import 'package:final_project_3/pages/profile_page.dart';
import 'package:final_project_3/pages/stickers_page.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class NavigationPage extends StatefulWidget {
  final User user;
  const NavigationPage(
      {super.key, required this.user});
  @override
  State<NavigationPage> createState() => _NavigationPageState(user: user);
}

class _NavigationPageState extends State<NavigationPage> {
  final User user;
  int _selectedIndex = 1;
  _NavigationPageState({required this.user});

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      ProfilePage(user: widget.user),
      HomePage(
        user: widget.user,
      ),
      StickersPage(
        user: widget.user,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        onTabChange: navigateBottomBar,
      ),
      body: _pages[_selectedIndex],
    );
  }
}
