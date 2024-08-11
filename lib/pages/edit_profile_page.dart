import 'package:final_project_3/pages/edit_profile_picture_page.dart';
import 'package:final_project_3/pages/ready_screen.dart';
import '../components/header.dart';
import '../components/input_text_field.dart';
import 'package:flutter/material.dart';
import '../components/wide_button.dart';
import '../models/user.dart';
import 'profile_page.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState(user: user);
}

class _EditProfilePageState extends State<EditProfilePage> {
  final User user;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  String? selectedGrade;
  _EditProfilePageState({required this.user});

  void initState() {
    super.initState();
  }

  void navigatorToProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilePage(
                  user: user,
                )));
        MaterialPageRoute(
            builder: (context) => ProfilePage(
                  user: user,
                ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Column(children: [
            const Header(title: "עריכת פרטי חשבון"),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      Stack(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.green, width: 4),
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('lib/images/child.png'),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange,
                              ),
                              child: IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.white),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditProfilePicturePage(
                                                user: user,
                                              )));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      InputTextField(
                        controller: firstNameController,
                        hintText: 'שם פרטי',
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      InputTextField(
                        controller: lastNameController,
                        hintText: 'שם משפחה',
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.only(right: 25),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'בחר כיתה',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: ['י', 'ט', 'ח', 'ז', 'ו', 'ה', 'ד', 'ג']
                                .map((grade) {
                              return Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedGrade = grade;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(255, 98, 247, 172),
                                          blurRadius: 1,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                      color: selectedGrade == grade
                                          ? const Color(0xFF31F091)
                                          : Colors.white,
                                      border: Border(
                                        right: grade != 'ג'
                                            ? const BorderSide(
                                                color: Colors.grey)
                                            : BorderSide.none,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        grade,
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: selectedGrade == grade
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      WideButton(
                        text: 'סיום',
                        onTap: () {
                          print('Button Pressed!');
                        },
                        color: "green",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
