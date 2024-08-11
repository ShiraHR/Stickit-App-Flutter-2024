import 'dart:io';

import 'package:final_project_3/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/input_text_field.dart';
import '../components/wide_button.dart';
import '../models/user.dart';
import 'profile_page.dart';

class CreateProfilePage extends StatefulWidget {
  final String email;
  CreateProfilePage({required this.email});

  @override
  _CreateProfilePageState createState() =>
      _CreateProfilePageState(email: email);
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final userService = UserService();
  final String email;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  String? selectedGrade;
  File? _image;
  final picker = ImagePicker();

  _CreateProfilePageState({required this.email});

  void setProfile() async {
    print("setProfile");
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        selectedGrade == null ||
        _image == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          title: Text('שים לב'),
          content: Text('אנא מלא את כל השדות'),
        ),
      );
      return;
    }
    final user = await User.create(
        email: email,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        grade: selectedGrade ?? '',
        image: _image ?? File('../images/ABC.png'));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilePage(
                  user: user,
                )));
  }

  Future pickImage(ImageSource source) async {
    var pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text('יצירת חשבון'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_right, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 58,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? CustomPaint(
                              size: Size(150, 150),
                              painter: MyIconPainter(),
                            )
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            pickImage(ImageSource.gallery);
                          },
                          child: Image.asset(
                            './lib/images/gallery.png',
                            height: 54,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            pickImage(ImageSource.camera);
                          },
                          child: Image.asset(
                            './lib/images/camera.png',
                            height: 54,
                          ),
                        )
                      ],
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
                                color: selectedGrade == grade
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
                  onTap: setProfile,
                  color: "green",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Head (upper circle)
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 4), size.width / 8, paint);

    // Body (lower circle)
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 1.5), size.width / 3, paint);

    // Camera icon (simplified version)
    paint.color = Color(0xFF00E676); // Green color
    Path path = Path();
    path.moveTo(size.width / 2 - size.width / 10, size.height / 1.5);
    path.lineTo(size.width / 2 + size.width / 10, size.height / 1.5);
    path.lineTo(size.width / 2 + size.width / 10, size.height / 1.8);
    path.lineTo(size.width / 2 + size.width / 15, size.height / 1.8);
    path.lineTo(size.width / 2 + size.width / 20, size.height / 1.85);
    path.lineTo(size.width / 2 - size.width / 20, size.height / 1.85);
    path.lineTo(size.width / 2 - size.width / 15, size.height / 1.8);
    path.lineTo(size.width / 2 - size.width / 10, size.height / 1.8);
    path.close();
    canvas.drawPath(path, paint);

    // Camera lens
    paint.color = Colors.white;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 1.55), size.width / 20, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
