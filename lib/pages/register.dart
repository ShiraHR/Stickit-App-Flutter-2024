import 'package:final_project_3/models/user.dart';
import 'package:final_project_3/pages/complete_profile_page.dart';
import 'package:final_project_3/pages/home_page.dart';
import 'package:final_project_3/services/user_service.dart';
import 'package:flutter/material.dart';
import '../components/input_text_field.dart';
import '../components/my_textfild.dart';
import '../components/wide_button.dart';
import '../services/auth_sevice.dart';
import 'login_page_one.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final authService = AuthService();
  final UserService _userService = UserService();

  void register() async {
    if (passwordController.text == confirmPasswordController.text) {
      try {
        await authService.signUpWithEmailPassword(
          emailController.text,
          passwordController.text,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CompleteProfilePage(email: emailController.text,)
          ),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: const Text("passwords don't match"),
        ),
      );
    }
  }

  void navigatorToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 248, 244),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Text(
                "Let's create an account for you",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 20),
              InputTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),
              const SizedBox(height: 10),
              InputTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: 10),
              InputTextField(
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                obscureText: true,
              ),
              const SizedBox(height: 20),
              WideButton(
                onTap: register,
                text: "Sign Up",
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a member?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: navigatorToLogin,
                    child: Text(
                      "Login now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
