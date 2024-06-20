import 'package:codedev/auth/auth_service.dart';
import 'package:codedev/components/custom_button.dart';
import 'package:codedev/components/custom_field.dart';
import 'package:codedev/constants.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});
  void signUp(BuildContext context) {
    final auth = AuthService();
    if (passwordController.text == confirmPasswordController.text) {
      try {
        auth.createUserWithEmailAndPassword(
          emailController.text,
          passwordController.text,
        );
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
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Passwords do not match',
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
          'Sign Up',
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
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SafeArea(
          child: Center(
            child: Column(children: [
              SizedBox(
                height: 50.0,
              ),
              Text(
                "Lets get started!",
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
              SizedBox(height: 25.0),
              CustomField(
                controller: confirmPasswordController,
                title: 'Confirm Password',
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
                      "Already have an account? ",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 25.0),
              CustomButton(
                onTap: () => signUp(context),
                text: 'Sign Up',
              )
            ]),
          ),
        ),
      ),
    );
  }
}
