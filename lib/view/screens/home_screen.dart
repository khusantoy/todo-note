import 'package:flutter/material.dart';
import 'package:todo_and_note/controllers/notes_controller.dart';
import 'package:todo_and_note/controllers/todo_controller.dart';
import 'package:todo_and_note/view/screens/courses_screen.dart';
import 'package:todo_and_note/view/screens/notes_screen.dart';
import 'package:todo_and_note/view/screens/todos_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            ? Text(
                AppLocalizations.of(context)!.todos,
                style: const TextStyle(
                  color: Color(0xFFDD761C),
                ),
              )
            : tabController.index == 1
                ? Text(
                    AppLocalizations.of(context)!.notes,
                    style: const TextStyle(
                      color: Color(0xFFDD761C),
                    ),
                  )
                : Text(
                    AppLocalizations.of(context)!.courses,
                    style: const TextStyle(
                      color: Color(0xFFDD761C),
                    ),
                  ),
        centerTitle: true,
        bottom: TabBar(
          dividerColor: const Color(0xFFFDE49E),
          indicatorColor: const Color(0xFFDD761C),
          labelColor: const Color(0xFF03AED2),
          controller: tabController,
          tabs: [
            Tab(
              text: AppLocalizations.of(context)!.todos,
              icon: const Icon(Icons.check_box),
            ),
            Tab(
              text: AppLocalizations.of(context)!.notes,
              icon: const Icon(Icons.edit_document),
            ),
            Tab(
              text: AppLocalizations.of(context)!.courses,
              icon: const Icon(Icons.school),
            )
          ],
        ),
        actions: [
          if (tabController.index == 2)
            PopupMenuButton(itemBuilder: (BuildContext context) {
              return [
                 PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(Icons.settings),
                      const SizedBox(width: 15),
                      Text(AppLocalizations.of(context)!.manage_courses)
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
