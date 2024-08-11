import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget{
  final void Function(int)? onTabChange;

  const BottomNavBar({super.key, required this.onTabChange});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 75,
      width: MediaQuery.of(context).size.width,
       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 34),
      decoration: BoxDecoration(
        color: Colors.white,
         borderRadius: BorderRadius.circular(70),
         boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), // 8% opacity
            offset: const Offset(0, 0),
            blurRadius: 34,
            spreadRadius: 0,
          ),
        ],
      ),
      child: GNav(
        onTabChange: onTabChange,
        tabMargin: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        color: Colors.grey[400],
        activeColor: Colors.white,
        tabBorderRadius: 27,
        tabBackgroundColor: Theme.of(context).colorScheme.onPrimary,
        gap: 60,
        selectedIndex: 1,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        tabs: const [
          GButton(icon: Icons.person_2_outlined),
          GButton(icon: Icons.home_outlined),
          GButton(icon: Icons.star_border_outlined)
        ],
      ),
    );
  }
}