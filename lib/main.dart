import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_and_note/services/auth_http_services.dart';
import 'package:todo_and_note/utils/theme.dart';
import 'package:todo_and_note/view/screens/auth/login_screen.dart';
import 'package:todo_and_note/view/screens/main_screen.dart';

void main() {
  runApp(const MyApp());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFFFDE49E),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authHttpServices = AuthHttpServices();
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    authHttpServices.checkAuth().then((value) {
      setState(() {
        isLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightThemeData(context),
      darkTheme: CustomTheme.darkThemeData(),
      themeMode: ThemeMode.light,
      home: isLoggedIn ? const MainScreen() : const LoginScreen(),
    );
  }
}
