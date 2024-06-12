import 'package:flutter/material.dart';
import 'package:todo_and_note/controllers/notes_controller.dart';
import 'package:todo_and_note/controllers/todo_controller.dart';
import 'package:todo_and_note/view/screens/courses_screen.dart';
import 'package:todo_and_note/view/screens/notes_screen.dart';
import 'package:todo_and_note/view/screens/todos_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
    tabController.addListener(() {
      setState(() {});
    });
  }

  final todosController = TodoController();
  final notesController = NotesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: tabController.index == 0
            ? const Text(
                "Todos",
                style: TextStyle(
                  color: Color(0xFFDD761C),
                ),
              )
            : tabController.index == 1
                ? const Text(
                    "Notes",
                    style: TextStyle(
                      color: Color(0xFFDD761C),
                    ),
                  )
                : const Text(
                    "Courses",
                    style: TextStyle(
                      color: Color(0xFFDD761C),
                    ),
                  ),
        centerTitle: true,
        bottom: TabBar(
          dividerColor: const Color(0xFFFDE49E),
          indicatorColor: const Color(0xFFDD761C),
          labelColor: const Color(0xFF03AED2),
          controller: tabController,
          tabs: const [
            Tab(
              text: "Todos",
              icon: Icon(
                Icons.check_box,
              ),
            ),
            Tab(
              text: "Notes",
              icon: Icon(Icons.edit_document),
            ),
            Tab(
              text: "Courses",
              icon: Icon(Icons.school),
            )
          ],
        ),
        actions: [
          if (tabController.index == 2)
            PopupMenuButton(itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 15),
                      Text("Manage Courses")
                    ],
                  ),
                ),
              ];
            })
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                TodosScreen(),
                NotesScreen(),
                CoursesScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
