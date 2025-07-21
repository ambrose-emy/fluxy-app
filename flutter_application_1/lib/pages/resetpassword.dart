import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token;

  ResetPasswordScreen({required this.token});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> resetPassword(String password) async {
    setState(() => isLoading = true);

    final response = await http.post(
      Uri.parse('https://yourapi.com/api/auth/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': widget.token, 'new_password': password}),
    );

    setState(() => isLoading = false);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Password reset successful')));
      context.go('/login'); // Redirect to login page
      //Navigator.popUntil(context, (route) => route.isFirst); // Go to login
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Reset failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "New Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  isLoading
                      ? null
                      : () {
                        final password = _passwordController.text.trim();
                        if (password.length >= 6) {
                          resetPassword(password);
                        }
                      },
              child: Text(isLoading ? "Resetting..." : "Reset Password"),
            ),
          ],
        ),
      ),
    );
  }
}
