import 'package:flutter/material.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const keyApplicationId =
      'HWKYDKtvD7paGojzw2ORhGRAKCy9erVeTgucpsmS'; // Replace with your Back4App App ID
  const keyClientKey =
      'hfoXyWnYiWZBsPD75BQYRf6jeVaQX9XjCbXl6l0w'; // Replace with your Back4App Client Key
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    autoSendSessionId: true,
    debug: true,
  );

  runApp(const MyApp());
}

class Parse {
  initialize(
    String keyApplicationId,
    String keyParseServerUrl, {
    required String clientKey,
    required bool autoSendSessionId,
    required bool debug,
  }) {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + Back4App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(), // Will create this page next
    );
  }
}
