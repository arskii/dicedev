import 'package:codedev/auth/login_or_signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${user?.email ?? 'Not available'}',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : AssetImage('assets/default_avatar.png')
                            as ImageProvider,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Name: ${user.displayName ?? 'Anonymous'}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginOrSignUp(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Text('Sign Out'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _showChangePasswordDialog(context);
                    },
                    child: Text('Change Password'),
                  ),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final _passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Password'),
        content: TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(hintText: 'Enter new password'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              String newPassword = _passwordController.text;
              if (newPassword.isNotEmpty) {
                try {
                  await _auth.currentUser?.updatePassword(newPassword);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password changed successfully')),
                  );
                } catch (e) {
                  if (e is FirebaseAuthException &&
                      e.code == 'requires-recent-login') {
                    Navigator.of(context).pop();
                    _showReauthenticationDialog(context, newPassword);
                  } else {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}')),
                    );
                  }
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Password cannot be empty')),
                );
              }
            },
            child: Text('Change'),
          ),
        ],
      ),
    );
  }

  void _showReauthenticationDialog(BuildContext context, String newPassword) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reauthenticate'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              String email = _emailController.text;
              String password = _passwordController.text;

              if (email.isNotEmpty && password.isNotEmpty) {
                try {
                  UserCredential userCredential =
                      await _auth.signInWithEmailAndPassword(
                          email: email, password: password);

                  if (userCredential.user != null) {
                    await userCredential.user?.updatePassword(newPassword);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password changed successfully')),
                    );
                  }
                } catch (e) {
                  Navigator.of(context).pop();
                  if (e is FirebaseAuthException &&
                      e.code == 'invalid-credential') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Invalid credentials. Please try again.')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}')),
                    );
                  }
                }
              }
            },
            child: Text('Reauthenticate'),
          ),
        ],
      ),
    );
  }
}
