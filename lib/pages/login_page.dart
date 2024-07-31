import 'package:codedev/auth/auth_service.dart';
import 'package:codedev/components/custom_button.dart';
import 'package:codedev/components/custom_field.dart';
import 'package:codedev/constants.dart';
import 'package:codedev/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50.0),
                const Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 25.0),
                CustomField(
                  controller: emailController,
                  title: 'Email',
                ),
                const SizedBox(height: 25.0),
                CustomField(
                  controller: passwordController,
                  title: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Forgot Password? ",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      GestureDetector(
                        onTap: onTap,
                        child: const Text(
                          "SignUp here",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                CustomButton(
                  onTap: () => login(context),
                  text: 'Login',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
