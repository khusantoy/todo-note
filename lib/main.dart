import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_and_note/models/course.dart';
import 'package:todo_and_note/models/lesson.dart';
import 'package:todo_and_note/view/screens/course_details_screen.dart';
import 'package:todo_and_note/view/screens/dashboard_screen.dart';
import 'package:todo_and_note/view/screens/lessons_screen.dart';
import 'package:todo_and_note/view/screens/main_screen.dart';
import 'package:todo_and_note/view/screens/profile_screen.dart';
import 'package:todo_and_note/view/screens/successful_payment_screen.dart';

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
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          return MaterialPageRoute(
            builder: (context) => const MainScreen(),
          );
        } else if (settings.name == '/dashboard') {
          return MaterialPageRoute(
            builder: (contex) => const DashboardScreen(),
          );
        } else if (settings.name == '/profile') {
          return MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          );
        } else if (settings.name == '/coursedetails') {
          return MaterialPageRoute(
            builder: (context) =>
                CourseDetailsScreen(course: settings.arguments as Course),
          );
        } else if (settings.name == '/successfulpaymentscreen') {
          return MaterialPageRoute(
            builder: (context) => SuccessfulPaymentScreen(
                lessons: settings.arguments as List<Lesson>),
          );
        } else if (settings.name == '/lessons') {
          return MaterialPageRoute(
            builder: (context) =>
                LessonsScreen(lessons: settings.arguments as List<Lesson>),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const MainScreen(),
        );
      },
    );
  }
}
