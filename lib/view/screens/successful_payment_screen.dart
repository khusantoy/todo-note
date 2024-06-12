import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_and_note/models/lesson.dart';

class SuccessfulPaymentScreen extends StatefulWidget {
  final List<Lesson> lessons;

  const SuccessfulPaymentScreen({super.key, required this.lessons});

  @override
  State<SuccessfulPaymentScreen> createState() =>
      _SuccessfulPaymentScreenState();
}

class _SuccessfulPaymentScreenState extends State<SuccessfulPaymentScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/lessons',
          arguments: widget.lessons);
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
