import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDE49E),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDE49E),
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
        onPressed: () {},
        child: Icon(
          tabController.index == 0 ? CupertinoIcons.add : Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
