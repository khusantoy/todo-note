import 'package:flutter/material.dart';
import 'package:todo_and_note/models/lesson.dart';
import 'package:todo_and_note/view/screens/dashboard_screen.dart';
import 'package:todo_and_note/view/screens/home_screen.dart';
import 'package:todo_and_note/view/screens/lesson_screen.dart';
import 'package:todo_and_note/view/screens/profile_screen.dart';

class LessonsScreen extends StatefulWidget {
  final List<Lesson> lessons;
  const LessonsScreen({super.key, required this.lessons});
  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  List<Widget> screens = [
    const HomeScreen(),
    const DashboardScreen(),
    const ProfileScreen()
  ];

  void _onTapped(int index) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return screens[index];
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lessons",
          style: TextStyle(
            color: Color(0xFFDD761C),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: widget.lessons.length,
        itemBuilder: (context, index) {
          final lesson = widget.lessons[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => LessonScreen(
                      lesson: lesson,
                      lessonIndex: index,
                    ),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: const Color(0xFFFEB941),
              leading: Card(
                shape: const CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (index + 1).toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              title: Text(
                lesson.title,
                style: const TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFFFDE49E),
        indicatorColor: const Color(0xFFFEB941),
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        onDestinationSelected: _onTapped,
      ),
    );
  }
}
