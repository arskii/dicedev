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
          ' ${user?.email ?? 'Not available'}',
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginOrSignUp(),
                          ));
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
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              }
            },
            child: Text('Change'),
          ),
        ],
      ),
    );
  }
}
