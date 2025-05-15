// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void doUserLogin() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    final user = ParseUser(username, password, null);
    var response = await user.login();

    if (response.success) {
      Navigator.pushReplacement(
        // ignore: duplicate_ignore
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      showDialog(
        // ignore: duplicate_ignore
        // ignore: use_build_context_synchronously
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("Error"),
              content: Text(response.error!.message),
            ),
      );
    }
  }

  void doUserSignUp() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    final user = ParseUser(username, password, null);
    var response = await user.signUp();

    if (response.success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("Error"),
              content: Text(response.error!.message),
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login / Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: doUserLogin, child: const Text('Login')),
            ElevatedButton(
              onPressed: doUserSignUp,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

extension on ParseUser {
  login() {}

  signUp() {}
}

class ParseUser {
  ParseUser(String username, String password, param2);
}
