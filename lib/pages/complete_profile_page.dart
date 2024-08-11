import 'dart:io';
import 'package:final_project_3/pages/ready_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../components/input_text_field.dart';
import '../components/wide_button.dart';
import '../models/user.dart';

class CompleteProfilePage extends StatefulWidget {
  final String email;

  const CompleteProfilePage({super.key, required this.email});

  @override
  State<CompleteProfilePage> createState() =>
      _CompleteProfilePageState(email: email);
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final gradeController = TextEditingController();
  String? selectedGrade;
  File? _profileImage;

  _CompleteProfilePageState({required String email});

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Use Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _createUser() async {
    String email = widget.email;
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String grade = selectedGrade ?? '';

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        grade.isEmpty ||
        _profileImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please fill all the fields and select an image.')),
      );
      return;
    }

    try {
      User newUser = await User.create(
        email: email,
        firstName: firstName,
        lastName: lastName,
        grade: grade,
        image: _profileImage!,
      );

      // Navigate to the ReadyScreen or show a success message
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ReadyScreen(
            user: newUser,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create user: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 20),
                child: Stack(
                  children: [
                    Positioned(
                      child: Image.asset(
                        './lib/images/planet.png',
                        alignment: AlignmentDirectional.topEnd,
                        height: 200,
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
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 120,
                height: 120,
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Color.fromARGB(255, 98, 247, 172), width: 4),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _profileImage != null
                              ? FileImage(_profileImage!)
                              : const AssetImage('lib/images/child.png')
                                  as ImageProvider,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 98, 247, 172),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt,
                                color: Colors.white),
                            onPressed: _showImageSourceActionSheet,
                            iconSize: 20,
                            padding: EdgeInsets.zero,
                            splashRadius: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                    border:
                        Border.all(color: Color.fromARGB(255, 98, 247, 172)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children:
                        ['י', 'ט', 'ח', 'ז', 'ו', 'ה', 'ד', 'ג'].map((grade) {
                      return Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedGrade = 'כיתה $grade';
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 98, 247, 172),
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                ),
                              ],
                              color: selectedGrade != null &&
                                      (selectedGrade![
                                              selectedGrade!.length - 1]) ==
                                          grade
                                  ? const Color(0xFF31F091)
                                  : Colors.white,
                              border: Border(
                                right: grade != 'ג'
                                    ? const BorderSide(color: Colors.grey)
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
                onTap: _createUser,
                color: "green",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
