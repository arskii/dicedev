import 'package:codedev/auth/auth_service.dart';
import 'package:codedev/components/custom_button.dart';
import 'package:codedev/components/custom_field.dart';
import 'package:codedev/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SafeArea(
          child: Center(
            child: Column(children: [
              SizedBox(
                height: 50.0,
              ),
              Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 25.0),
              CustomField(
                controller: emailController,
                title: 'Email',
              ),
              SizedBox(height: 25.0),
              CustomField(
                controller: passwordController,
                title: 'Password',
                obscureText: true,
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password? ",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Text("SignUp here",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.0),
              CustomButton(
                onTap: () => login(context),
                text: 'Login',
              )
            ]),
          ),
        ),
      ),
    );
  }
}
