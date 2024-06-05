import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_and_note/view/screens/lessons_screen.dart';

class SuccessfulPaymentScreen extends StatefulWidget {
  const SuccessfulPaymentScreen({super.key});

  @override
  State<SuccessfulPaymentScreen> createState() =>
      _SuccessfulPaymentScreenState();
}

class _SuccessfulPaymentScreenState extends State<SuccessfulPaymentScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => const LessonsScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/lottie_animation.json',
              repeat: false,
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
            const Text(
              "Successfully Enrolled",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
