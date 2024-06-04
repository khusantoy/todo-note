import 'package:flutter/material.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15.0),
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(10),
          tileColor: const Color(0xFFFEB941),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          leading: Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              "https://corpit.net.au/wp-content/uploads/2021/12/Corp-IT_Home-Page-Feature_1920x1080.jpg",
              fit: BoxFit.cover,
            ),
          ),
          title: const Text(
            "Flutter programming",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "In this course you will learn...",
            style: TextStyle(
              color: Colors.grey.shade100,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(10),
          tileColor: const Color(0xFFFEB941),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          leading: Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              "https://corpit.net.au/wp-content/uploads/2021/12/Corp-IT_Home-Page-Feature_1920x1080.jpg",
              fit: BoxFit.cover,
            ),
          ),
          title: const Text(
            "Flutter programming",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "In this course you will learn...",
            style: TextStyle(
              color: Colors.grey.shade100,
            ),
          ),
        )
      ],
    );
  }
}
