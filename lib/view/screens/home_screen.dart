import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_and_note/controllers/note_controller.dart';
import 'package:todo_and_note/controllers/todo_controller.dart';
import 'package:todo_and_note/view/screens/notes_screen.dart';
import 'package:todo_and_note/view/screens/todos_screen.dart';
import 'package:todo_and_note/view/widgets/manage_note_dialog.dart';
import 'package:todo_and_note/view/widgets/manage_todo_dialog.dart';

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
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
    tabController.addListener(() {
      setState(() {});
    });
  }

  final todosController = TodoController();
  final notesController = NoteController();
  void addTodo() async {
    final data = await showDialog(
      context: context,
      builder: (ctx) {
        return const ManageTodoDialog();
      },
    );

    if (data != null) {
      try {
        todosController.addTodo(
          data['id'],
          data['title'],
          data['isCompleted'] ?? false,
        );
        setState(() {});
      } catch (e) {
        print(e);
      }
    }
  }

  void addNote() async {
    final data = await showDialog(
      context: context,
      builder: (ctx) {
        return const ManageNoteDialog();
      },
    );

    if (data != null) {
      try {
        notesController.addNote(
          data['id'],
          data['title'],
        );
        setState(() {});
      } catch (e) {
        print(e);
      }
    }
  }

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
            : const Text(
                "Notes",
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
                Icons.check_box_outlined,
              ),
            ),
            Tab(
              text: "Notes",
              icon: Icon(Icons.note),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                TodosScreen(),
                NotesScreen(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF03AED2),
        onPressed: tabController.index == 0 ? addTodo : addNote,
        child: Icon(
          tabController.index == 0 ? CupertinoIcons.add : Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
