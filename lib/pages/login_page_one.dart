import 'package:final_project_3/components/input_text_field.dart';
import 'package:final_project_3/models/user.dart';
import 'package:final_project_3/pages/ready_screen.dart';
import 'package:flutter/material.dart';

import '../components/my_textfild.dart';
import '../components/wide_button.dart';
import '../models/user.dart';
import '../services/auth_sevice.dart';
import '../services/user_service.dart';
import 'register.dart';
import '../services/user_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passWordController = TextEditingController();

  void login() async {
    final authService = AuthService();
    final userService = UserService();

    try {
      await authService.signInWithEmailPassword(
        emailController.text,
        passWordController.text,
      );
      User user = await userService.getUser(emailController.text);
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ReadyScreen(user:user,)),
      );
    } catch (e) {
      String errorMessage = authService.getErrorMessage(e.toString());
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Text(errorMessage)),
      );
    }
  }

  void navigatorToRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Stack(
                children: [
                  Positioned(
                    child: Image.asset(
                      'lib/images/planet.png', // בדוק את הנתיב הזה
                      alignment: AlignmentDirectional.topEnd,
                      height: 200,
                    ),
                  ),
                  Positioned(
                    top: 85,
                    left: 79,
                    child: Image.asset(
                      'lib/images/game_name.png', // בדוק את הנתיב הזה
                      alignment: Alignment.center,
                      width: 200,
                    ),
                  ),
                ],
              ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Welcome!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 50),
                InputTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                InputTextField(
                  controller: passWordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                WideButton(onTap: () => login(), text: "login"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: navigatorToRegister,
                      child: Text(
                        "Register now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
