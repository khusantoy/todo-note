import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_and_note/view/screens/main_screen.dart';

void main() {
  runApp(const MyApp());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFFFDE49E),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFDE49E),
          centerTitle: true,
        ),
        scaffoldBackgroundColor: const Color(0xFFFDE49E),
      ),
      home: const MainScreen(),
    );
  }
}
